package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}
		
		public function playSong (song : int) {
			this.mainPlayer.playSong(song);
		}
		
		private function gotoF(e:Event):void{
			//notebookClickHandler(null);
		}
		
		private function addedToStageHandler(e : Event) : void {
			startBTN.addEventListener(MouseEvent.CLICK, this.startBTNClickHandler);
		}
		
		private function startBTNClickHandler(e : MouseEvent) : void {
			var req:URLRequest = new URLRequest ("audio/sounds/dver'.mp3");
			var sound:Sound = new Sound();			
			sound.load(req);			
			var channel = sound.play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.enterHandler);
		}
		
		private function enterHandler(e : Event) : void {			
			//test
			//this.adapterClickHandler(null);
			this.gotoAndStop(2);
			this.mainPlayer = new MainPlayer();	
			
			var timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.startTimerHandler);
			timer.start();
		}
		
		private function startTimerHandler(e : TimerEvent) : void {		
			var channel = momSounds[0].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.whereIsKeysCompleteHandler);
		}
		
		private function whereIsKeysCompleteHandler(e : Event) : void {
			this.missionReceivedHandler();
			this.mainPlayer.fadeIn();
			hiddenKeys.visible = true;
			hiddenKeys.addEventListener(MouseEvent.CLICK, this.hiddenKeysClickHandler);
		}
		
		private function hiddenKeysClickHandler(e : MouseEvent) : void {
			this.gotoAndStop(3);
			keys.addEventListener(MouseEvent.CLICK, this.keysClickHandler);
		}
		
		private function keysClickHandler(e : MouseEvent) : void {
			(new KeysSound()).play();
			keys.visible = false;
			
			this.mainPlayer.fadeOut();
			var channel = momSounds[1].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startTemaFinding);
		}
		
		private function startTemaFinding(e : Event) : void {
			this.mainPlayer.fadeIn();
			chair.visible = true;
			chair.addEventListener(MouseEvent.CLICK, this.chairClickHandler);
		}
		
		private function chairClickHandler(e : MouseEvent) : void {
			(new ChairSound()).play();
			this.gotoAndStop(4);
			curtain.addEventListener(MouseEvent.CLICK, this.curtainClickHandler);
		}
		
		private function curtainClickHandler(e : MouseEvent) : void {
			(new CurtainSound()).play();
			this.gotoAndStop(5);
			
			this.mainPlayer.fadeOut();
			var channel = momSounds[2].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.temaFound);
			
			var timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.temaTimerHandler);
			timer.start();
		}
		
		private function temaTimerHandler(e : TimerEvent) : void {
			this.gotoAndStop(6);
		}
		
		private function temaFound(e : Event) : void {
			var req:URLRequest = new URLRequest ("audio/phone_ringing.mp3");
			var sound:Sound = new Sound();			
			sound.load(req);
			
			this.phoneChannel = sound.play(0, 999, new SoundTransform(0.7));
			
			var timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.phoneTimerHandler);
			timer.start();
		}
		
		private function phoneTimerHandler(e : TimerEvent) : void {
			var channel = momSounds[3].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startFindPhone);
		}
		
		private function startFindPhone(e : Event) : void {
			adapter.visible = true;
			adapter.addEventListener(MouseEvent.CLICK, this.adapterClickHandler);
		}
		
		private function adapterClickHandler(e : MouseEvent) : void {
			(new AdapterSound()).play();
			this.gotoAndStop(7);
			phone.addEventListener(MouseEvent.CLICK, this.phoneClickHandler);
		}
		
		private function phoneClickHandler(e : MouseEvent) : void {
			phone.visible = false;
			this.phoneChannel.stop();
			
			var channel = momSounds[4].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startFindPresent);
		}
		
		private function startFindPresent(e : Event) : void {
			this.mainPlayer.fadeIn();
			notebook.visible = true;
			notebook.addEventListener(MouseEvent.CLICK, this.notebookClickHandler);
		}
		
		private function notebookClickHandler(e : MouseEvent) : void {
			//this.mainPlayer = new MainPlayer();
			
			(new PageSound).play(0, 0, new SoundTransform(0.2));
			this.gotoAndStop(8);
			test.player = this.mainPlayer;
			this.mainPlayer.changePlaylist();
		}
		
		private function missionReceivedHandler () : void {
			missionReceived.gotoAndPlay(1);
			this.zadanie.play(1000);
		}
		
		/**
		* class properties
		**/
		
		private var momSounds		: Array = new Array(
														new WhereIsKeys(), 
														new WhereIsTema(), 
														new TemaIsFound(),
														new WhereIsPhone(),
														new Present()
														);
		
		private var zadanie			: Zadanie = new Zadanie();
		
		private var phoneChannel	: SoundChannel;
		private var mainPlayer		: MainPlayer;
		
		
	}
	
}
