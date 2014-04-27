package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}
		
		private function gotoF(e:Event):void{
			//notebookClickHandler(null);
		}
		
		private function addedToStageHandler(e : Event) {
			startBTN.addEventListener(MouseEvent.CLICK, this.startBTNClickHandler);
		}
		
		private function startBTNClickHandler(e : MouseEvent) {
			this.gotoAndStop(2);
			var channel = momSounds[0].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.whereIsKeysCompleteHandler);
		}
		
		private function whereIsKeysCompleteHandler(e : Event) {
			hiddenKeys.visible = true;
			hiddenKeys.addEventListener(MouseEvent.CLICK, this.hiddenKeysClickHandler);
		}
		
		private function hiddenKeysClickHandler(e : MouseEvent) {
			this.gotoAndStop(3);
			keys.addEventListener(MouseEvent.CLICK, this.keysClickHandler);
		}
		
		private function keysClickHandler(e : MouseEvent) {
			(new KeysSound()).play();
			keys.visible = false;
			var channel = momSounds[1].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startTemaFinding);
		}
		
		private function startTemaFinding(e : Event) {			
			chair.visible = true;
			chair.addEventListener(MouseEvent.CLICK, this.chairClickHandler);
		}
		
		private function chairClickHandler(e : MouseEvent) {
			(new ChairSound()).play();
			this.gotoAndStop(4);
			curtain.addEventListener(MouseEvent.CLICK, this.curtainClickHandler);
		}
		
		private function curtainClickHandler(e : MouseEvent) {
			(new CurtainSound()).play();
			this.gotoAndStop(5);
			
			var channel = momSounds[2].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.temaFound);
			
			var timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.temaTimerHandler);
			timer.start();
		}
		
		private function temaTimerHandler(e : TimerEvent) {
			this.gotoAndStop(6);
		}
		
		private function temaFound(e : Event) {
			this.phoneChannel = momSounds[4].play();
			
			var timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.phoneTimerHandler);
			timer.start();
		}
		
		private function phoneTimerHandler(e : TimerEvent) {
			var channel = momSounds[3].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startFindPhone);
		}
		
		private function startFindPhone(e : Event) {
			adapter.visible = true;
			adapter.addEventListener(MouseEvent.CLICK, this.adapterClickHandler);
		}
		
		private function adapterClickHandler(e : MouseEvent) {
			(new AdapterSound()).play();
			this.gotoAndStop(7);
			phone.addEventListener(MouseEvent.CLICK, this.phoneClickHandler);
		}
		
		private function phoneClickHandler(e : MouseEvent) {
			phone.visible = false;
			this.phoneChannel.stop();
			
			var channel = momSounds[5].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startFindPresent);
		}
		
		private function startFindPresent(e : Event) {
			notebook.visible = true;
			notebook.addEventListener(MouseEvent.CLICK, this.notebookClickHandler);
		}
		
		private function notebookClickHandler(e : MouseEvent) {
			(new PageSound).play();
			this.gotoAndStop(8);
		}
		
		/**
		* class properties
		**/
		
		private var momSounds		: Array = new Array(
														new WhereIsKeys(), 
														new WhereIsTema(), 
														new TemaIsFound(),
														new WhereIsPhone(),
														new PhoneRinging(),
														new Present()
														);
		
		private var phoneChannel	: SoundChannel;
		
		
	}
	
}
