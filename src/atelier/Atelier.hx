package atelier;

import kha.Scheduler;
import haxe.io.Path;
import dreamengine.plugins.dreamui.elements.Button;
import dreamengine.plugins.dreamui.styling.Selector;
import dreamengine.plugins.dreamui.styling.Style;
import kha.Assets;
import dreamengine.plugins.dreamui.utils.XMLBuilder;
import dreamengine.plugins.dreamui.DreamUIPlugin;
import dreamengine.core.Plugin.IPlugin;
import dreamengine.core.Game;

class Atelier extends Game {
	override function beginGame() {
		var ui = engine.pluginContainer.getPlugin(DreamUIPlugin);

		var main = XMLBuilder.build(Assets.blobs.get("main_xml").readUtf8String());
		ui.getScreenElement().setStyle(Style.fromJson(Assets.blobs.get("style_json").readUtf8String()));

		ui.setMainElement(main);

		main.setDirty();

		var projectLoad = Project.loadFromPath("/home/metin/Projects/testdreamgame/dreamgame.json");
		var project:Project;
		switch (projectLoad) {
			case Some(v):
				trace("Project loaded." + v);
				project = v;
			case None:
				throw("Project could not be loaded");
		}
		main.query(new Selector("#run"), Button).registerClickedEvent(function() {
			
			trace("Building");
			trace('node ${Path.join([project.getPath(), "Kha/make"])} --from ${project.getPath()} --run debug-html5 --debug --atelier');
			var process = new sys.io.Process('node ${Path.join([project.getPath(), "Kha/make"])} --from ${project.getPath()} --run debug-html5 --debug --atelier');
		});
	}

	override function getDependentPlugins():Array<Class<IPlugin>> {
		return [DreamUIPlugin];
	}

	override function handleDependency(ofType:Class<IPlugin>):IPlugin {
		switch (ofType) {
			case DreamUIPlugin:
				return new DreamUIPlugin();
		}
		return null;
	}
}
