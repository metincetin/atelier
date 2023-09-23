package atelier;

class Notification{
    public static function send(message:String, title:String=""){
        var os = Sys.systemName();
        switch(os){
            case "Linux":
                Sys.command('notify-send "${title}" "${message}"');
        }
    }
}