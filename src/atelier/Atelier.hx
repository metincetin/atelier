package atelier;

import dreamengine.plugins.dreamui.containers.VerticalBoxContainer;
import dreamengine.plugins.dreamui.elements.Label;
import dreamengine.plugins.dreamui.containers.HorizontalBoxContainer;
import dreamengine.plugins.dreamui.layout_parameters.VerticalBoxLayoutParameters;
import dreamengine.core.math.Vector2;
import dreamengine.plugins.dreamui.layout_parameters.CanvasLayoutParameters;
import dreamengine.plugins.dreamui.styling.Style;
import kha.Assets;
import dreamengine.plugins.dreamui.utils.XMLBuilder;
import dreamengine.plugins.dreamui.DreamUIPlugin;
import dreamengine.core.Plugin.IPlugin;
import dreamengine.core.Game;

class Atelier extends Game{

    override function beginGame() {
        var ui = engine.pluginContainer.getPlugin(DreamUIPlugin);

        
        
        var main = XMLBuilder.build(Assets.blobs.get("main_xml").readUtf8String());
        ui.getScreenElement().setStyle(Style.fromJson(Assets.blobs.get("style_json").readUtf8String()));
        


        var l = cast(main.getChild(0), Label);
        l.setAlignment(1);

        var i = main.getChild(1).getChild(0);
        
        i.getLayoutParametersAs(VerticalBoxLayoutParameters).horizontalAlignment = Center;
        

        ui.setMainElement(main);

        main.setDirty();
    }

    override function getDependentPlugins():Array<Class<IPlugin>> {
        return [DreamUIPlugin];
    }

    override function handleDependency(ofType:Class<IPlugin>):IPlugin {
        switch(ofType){
            case DreamUIPlugin:
                return new DreamUIPlugin();
        }
        return null;
    }
}