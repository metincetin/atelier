package;

import atelier.Atelier;
import kha.Assets;
import dreamengine.core.Engine;

class Main {
	public static function main() {
		Engine.start(function(engine) {
			Assets.loadEverything(function() {
				engine.pluginContainer.addPlugin(new Atelier());
			});
		});

		
	}
}
