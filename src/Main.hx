package;

import atelier.Atelier;
import kha.Assets;
import dreamengine.core.Engine;
import kha.System;

class Main {
	public static function main() {
		var engine = new Engine();
		Assets.loadEverything(function(){
			engine.pluginContainer.addPlugin(new Atelier());
		});
	}
}
