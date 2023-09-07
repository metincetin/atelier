package atelier;

import sys.io.Process;
import sys.thread.Thread;

class Dialogue {
	public static function message(msg:String) {
		var desktop = Sys.getEnv("XDG_CURRENT_DESKTOP");
		switch (desktop) {
			case "GNOME":
				Thread.create(() -> {
					Sys.command('zenity --info --text="${msg}"');
				});
			case "KDE":
		}
	}

	public static function file(filter:String) {
        var process = new Process('zenity --file-selection --file-filter="${filter}"');
        return process.stdout.readLine();
	}

}
