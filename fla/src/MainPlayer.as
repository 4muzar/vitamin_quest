package  {
	
	import com.greensock.*;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	
	public class MainPlayer {
		
		
		public function MainPlayer() {
			this.playlist = this.songs;
			this.playSong();
			this.fadeOut();
		}
		
		public function changePlaylist () : void {
			TweenMax.to(this.soundChannel, 1, { volume:this.FADE, startAt: { volume:this.VOLUME }, onComplete:this.stopPlaylist });
		}
		
		public function fadeIn () : void {
			TweenMax.to(this.soundChannel, 2, { volume:this.VOLUME, startAt: { volume:this.FADE } });			
		}
		
		public function fadeOut () : void {
			TweenMax.to(this.soundChannel, 2, { volume:this.FADE, startAt: { volume:this.VOLUME } });			
		}
		
		public function playSong (nextSong : int = -1) : void {
			
			if (nextSong != -1) this.song = nextSong;
			
			var req:URLRequest = new URLRequest (this.playlist[this.song]);
			var sound:Sound = new Sound();
			
			sound.load(req);
			if (this.soundChannel) this.soundChannel.stop();
			this.soundChannel = sound.play(0, 0, this.soundTransform);
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, this.finishSong);
		}
		
		private function finishSong (e : Event) : void {
			if (this.playlist == this.songs) {
				if (++this.song == this.playlist.length) this.song = 0;
				this.playSong();				
			}
		}
		
		private function stopSound () : void {
			this.soundChannel.stop();
		}
		
		private function stopPlaylist () : void {			
			this.playlist = this.fromGames;
			this.song = 0;
			this.playSong();
		}
		
/*****************
* class properties
*****************/
		
		private const VOLUME		: Number = 0.2;
		private const FADE			: Number = 0.05;		
		
		private var soundTransform 	: SoundTransform = new SoundTransform(0.2);
		private var soundChannel	: SoundChannel;
		private var song			: int = 0;
		
		private var playlist		: Array;
		private var songs			: Array = new Array(
														"audio/music/trassae95.mp3", 
														"audio/music/loshadka.mp3", 
														"audio/music/secret.mp3",
														"audio/music/kon.mp3"
														);
														
		private var fromGames		: Array = new Array(
														"audio/from_games/age_of_empires.mp3", 
														"audio/from_games/neverhood.mp3", 
														"audio/from_games/caesar3.mp3",
														"audio/from_games/heroes2.mp3",
														"audio/from_games/mm6.mp3",
														"audio/from_games/gag.mp3",														
														"audio/from_games/heroes3.mp3",														
														"audio/from_games/ostrov.mp3"
														);
	}
	
}
