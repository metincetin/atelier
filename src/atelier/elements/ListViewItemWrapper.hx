package atelier.elements;

import dreamengine.plugins.dreamui.events.IClickable;
import dreamengine.plugins.dreamui.*;
import dreamengine.plugins.dreamui.events.IPointerTarget;

class ListViewItemWrapper extends Element implements IPointerTarget implements IClickable{
    public var pressed:Void->Void;
    
    public function new (element:Element){
        super();
        addChild(element);
    }

    public function getElement(){
        return getChild(0);
    }

    public function canBeTargeted():Bool {
        return true;
    }

    public function onPointerEntered() {
        trace("ENTERED");
    }

    public function onPointerExited() {}

    public function onPressed() {
        if (pressed != null) pressed();
    }

    public function onReleased() {}
    override function layout() {
        var e = getElement();
        e.rect.setPosition(rect.getPosition());
        e.rect.setSize(rect.getSize());
    }
}
    