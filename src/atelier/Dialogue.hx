package atelier;

import sys.io.Process;
import sys.thread.Thread;

#if kha_windows
@:headerCode("#include <dialogue.h>")
#end
class Dialogue {
	#if kha_windows
	@:functionCode('return native_message(msg, title);')
	static function messageWin(msg:String, title:String) {}

	@:functionCode('return native_win_file();')
	static function nativeWinFile():String {
		return "";
	}
	#end

	public static function message(msg:String, title:String) {
		#if kha_windows
		messageWin(msg, title);
		return;
		#end
		switch (Sys.systemName()) {
			case "Linux":
				var desktop = Sys.getEnv("XDG_CURRENT_DESKTOP");
				Thread.create(() -> {
					switch (desktop) {
						case "KDE":
							Sys.command('kdialog --msgbox "${msg}" --title ${title}');
						case "GNOME":
						case _:
							Sys.command('zenity --info --text="${msg}" --title="${title}"');
					}
				});
		}
	}

	public static function file(filter:String) {
		#if kha_windows
		return nativeWinFile();
		#end

		switch (Sys.systemName()) {
			case "Linux":
				var desktop = Sys.getEnv("XDG_CURRENT_DESKTOP");
				var command = "";
				switch (desktop) {
					case "KDE":
						command = 'kdialog --getopenfilename . "${filter}"';
					case "GNOME":
					case _:
						command = 'zenity --file-selection --file-filter="${filter}"';
				}
				var process = new Process(command);
				return process.stdout.readLine();
		}

		return "";
	}
}
