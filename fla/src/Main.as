package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}
		
		private function addedToStageHandler(e : Event) {
			hiddenKeys.addEventListener(MouseEvent.CLICK, this.hiddenKeysClickHandler);
		}
		
		private function hiddenKeysClickHandler(e : MouseEvent) {
			this.gotoAndStop(2);
			keys.addEventListener(MouseEvent.CLICK, this.keysClickHandler);
		}
		
		private function keysClickHandler(e : MouseEvent) {
			keys.visible = false;
			chair.visible = true;
			chair.addEventListener(MouseEvent.CLICK, this.chairClickHandler);
		}
		
		private function chairClickHandler(e : MouseEvent) {
			this.gotoAndStop(3);
			curtain.addEventListener(MouseEvent.CLICK, this.curtainClickHandler);
		}
		
		private function curtainClickHandler(e : MouseEvent) {
			this.gotoAndStop(4);
			
			var timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.temaTimerHandler);
			timer.start();
		}
		
		private function temaTimerHandler(e : TimerEvent) {
			this.gotoAndStop(5);
			adapter.addEventListener(MouseEvent.CLICK, this.adapterClickHandler);
		}
		
		private function adapterClickHandler(e : MouseEvent) {
			this.gotoAndStop(6);
			phone.addEventListener(MouseEvent.CLICK, this.phoneClickHandler);
		}
		
		private function phoneClickHandler(e : MouseEvent) {
			phone.visible = false;
			notebook.visible = true;
			notebook.addEventListener(MouseEvent.CLICK, this.notebookClickHandler);
		}
		
		private function notebookClickHandler(e : MouseEvent) {
			
		}
		
		
	}
	
}
