package atelier.elements;

import dreamengine.plugins.dreamui.Element;

class ListView extends Element {
	var elementCreator:Void->Element;
	var drawer:(Element, Int, Dynamic) -> Void;
	var data:Array<Dynamic>;

	public function setElementCreator(value:Void->Element) {
		elementCreator = value;
	}

	public function setDrawer(value:(Element, Int, Dynamic) -> Void) {
		drawer = value;
	}

	public function setData(value:Array<Dynamic>) {
		data = value;
	}

	public function refresh() {
		for (i in 0...data.length) {
			var d = data[i];
			var e = elementCreator();
			drawer(e, i, d);

            var wrapper = new ListViewItemWrapper(e);

            wrapper.pressed = ()->{
                trace('Pressed item ${e} ${i} ${data}');
            };
            addChild(wrapper);

		}
		setDirty();
	}

	override function layout() {
		var y = 0.0;
		var startPos = rect.getPosition();
		for (c in children) {
            var wrapper: ListViewItemWrapper = cast c;
			wrapper.rect.setPosition([startPos.x, startPos.y + y]);
			y += wrapper.getElement().getPreferredSize().y;
            c.setDirty();
		}
	}
}
