package atelier;

import atelier.elements.ListView;
import dreamengine.plugins.dreamui.utils.UIXMLElementTypes;
import haxe.io.Eof;
import sys.thread.Thread;
import dreamengine.plugins.dreamui.layout_parameters.CanvasLayoutParameters;
import dreamengine.plugins.dreamui.containers.CanvasContainer;
import kha.Canvas;
import dreamengine.plugins.dreamui.elements.Label;
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
	public static var version = "0.1.0";

	var project:Project;

	override function beginGame() {

		UIXMLElementTypes.registerType("ListView", ListView);

		var ui = engine.pluginContainer.getPlugin(DreamUIPlugin);

		var main = cast XMLBuilder.build(Assets.blobs.get("main_xml").readUtf8String());
		ui.getScreenElement().setStyle(Style.fromJson(Assets.blobs.get("style_json").readUtf8String()));

		ui.setMainElement(main);


		main.query("#version", Label).setText(version);

		
		main.query("#open", Button).registerClickedEvent(() -> {
			var res = Dialogue.file("*.json");
			trace(res);
			var projectLoad = Project.loadFromPath(res);
			switch (projectLoad) {
				case Some(v):
					trace("Project loaded. " + v.getPath());
					project = v;
					var projectTitle = main.query("#projectTitle", Label);
					projectTitle.setText(project.getName());
					projectTitle.removeStyleClass("collapsed");
					applyProject();

				case None:
					throw("Project could not be loaded");
			}
		});
		main.query(new Selector("#run"), Button).registerClickedEvent(function() {
			Thread.create(() -> {
				var process = new sys.io.Process('node ${Path.join([project.getPath(), "Kha/make"])} --from ${project.getPath()} --run --debug --atelier');
				try {
					while (true) {
						var line = process.stdout.readLine();
						trace(line);
					}
				} catch (e:Eof) {
					Notification.send("Compiled successfully");
				}
			});
		});

		/*
		var listView = main.query("#assetView", ListView);
		listView.setData(["Hello", "a", "b","c"]);
		listView.setElementCreator(() -> return new Label());
		listView.setDrawer((element, index, data) -> cast(element, Label).setText(cast data));

		listView.refresh();
		*/
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

	function applyProject() {
		if (project == null)
			return;
	}
}
