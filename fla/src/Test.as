package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	
	public class Test extends MovieClip {
		
		
		public function Test() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}
		
		private function addedToStageHandler(e : Event) : void {
			this.addEventListener(MouseEvent.CLICK, this.clickHandler);
		}
		
		private function clickHandler(e : MouseEvent) : void {
			if (e.target is Variant) {
				var variant : int = int(e.target.name.charAt(3));
				if (variant == this.correctAnswers[this.page-1]) {
					(indicator as MovieClip).gotoAndStop(++this.correct + 1);
					this.removeWrongAnswer(this.page);
				} else this.addWrongAnswer(this.page);
				this.goToNextPage(this.page + 1);
			}
		}
		
		private function addWrongAnswer (answer : int) : void {
			if (this.wrongAnswers.indexOf(answer) == -1) {
				this.wrongAnswers.push(answer);
			}
		}
		
		private function removeWrongAnswer (answer : int) : void {			
			var wrongIndex : int = this.wrongAnswers.indexOf(answer);
			if (wrongIndex != -1) {
				this.wrongAnswers.splice(wrongIndex, 1);
			}
		}
		
		private function goToNextPage(p) : void {
			if (this.firstCycle && this.wrongAnswers.length == 0) {
				this.gotoAndStop(++this.page);
			} else {
				if (this.firstCycle && p < 8) {
					this.gotoAndStop(++this.page);
				} else {
					if (p == 8 && this.firstCycle) {
						this.firstCycle = false;
						this.page = this.wrongAnswers[0];
						this.gotoAndStop(this.page);
					} else if (this.wrongAnswers.length == 0) {
						this.page = 8;
						this.gotoAndStop(this.page);
					} else {
						this.page = this.wrongAnswers[0];
						this.gotoAndStop(this.page);
					}					
				}
			}
			this.pageSound.play(0, 0, new SoundTransform(0.2));
			(parent as Main).playSong(this.page-1);			
		}
		
		/**
		* class properties
		**/
		
		private var correctAnswers		: Array = new Array(3, 2, 2, 4, 4, 4, 1);
		private var wrongAnswers		: Array = new Array();
		private var page				: int = 1;
		private var pageSound			: Sound = new PageSound();
		private var firstCycle			: Boolean = true;
		private var correct				: int = 0;
	}
	
}
