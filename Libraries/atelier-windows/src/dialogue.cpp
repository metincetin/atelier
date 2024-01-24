#include "windows.h"
#include "dialogue.h"
#include <ShObjIdl_core.h>
#include "stdio.h"


void native_message(const char* message, const char* title){
    HWND hwndOwner = NULL;
    UINT uType = MB_OK | MB_ICONINFORMATION;
    MessageBoxA(hwndOwner, message, title, uType);
}

const char* native_win_file() {
    IFileOpenDialog* fileOpen;
    HRESULT hr = CoCreateInstance(CLSID_FileOpenDialog, NULL, CLSCTX_ALL, IID_IFileOpenDialog, reinterpret_cast<void**>(&fileOpen));

    char* filePath = "";

    printf("Loading win file dialog");
    if (SUCCEEDED(hr)) {
        hr = fileOpen->Show(NULL);
        if (SUCCEEDED(hr)) {
            IShellItem* pItem;
            hr = fileOpen->GetResult(&pItem);

            if (SUCCEEDED(hr)) {
                PWSTR pszFilePath;
                hr = pItem->GetDisplayName(SIGDN_FILESYSPATH, &pszFilePath);

                if (SUCCEEDED(hr)) {
                    int bufferSize = WideCharToMultiByte(CP_UTF8, 0, pszFilePath, -1, NULL, 0, NULL, NULL);
                    filePath = new char[bufferSize];
                    WideCharToMultiByte(CP_UTF8, 0, pszFilePath, -1, filePath, bufferSize, NULL, NULL);
                    CoTaskMemFree(pszFilePath);
                }

                pItem->Release();
            }
        }

        fileOpen->Release();

    }
    return filePath;
}