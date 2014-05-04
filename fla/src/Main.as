﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	
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
			this.mainPlayer = new MainPlayer();
			
			//test
			//this.adapterClickHandler(null);
			this.gotoAndStop(2);
			var channel = momSounds[0].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.whereIsKeysCompleteHandler);
		}
		
		private function whereIsKeysCompleteHandler(e : Event) : void {
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
			var channel = momSounds[1].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startTemaFinding);
		}
		
		private function startTemaFinding(e : Event) : void {			
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
			this.phoneChannel = momSounds[4].play();
			
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
			
			var channel = momSounds[5].play();
			channel.addEventListener(Event.SOUND_COMPLETE, this.startFindPresent);
		}
		
		private function startFindPresent(e : Event) : void {
			notebook.visible = true;
			notebook.addEventListener(MouseEvent.CLICK, this.notebookClickHandler);
		}
		
		private function notebookClickHandler(e : MouseEvent) : void {
			(new PageSound).play(0, 0, new SoundTransform(0.2));
			this.gotoAndStop(8);
			this.mainPlayer.changePlaylist();
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
		private var mainPlayer		: MainPlayer;
		
		
	}
	
}
