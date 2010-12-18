var tae;

function createTextAreaEvent(textName) {
	tae = new textArea_Event(textName);
}

function textArea_Event(oTextName) {
	// initialize member variables
	this.oTextName = oTextName;
	this.oText = document.getElementById(oTextName);

	// attach handlers to the text-box
	this.oText.textArea_Event = this;
	this.oText.onkeyup = textArea_Event.prototype.onTextChange;
	this.oText.onclick = textArea_Event.prototype.onClick;
	this.oText.onselect = textArea_Event.prototype.onSelect;
}

/*
	Modify text range object, apply the createTextRange method to a body,
	button, or textArea element or an input element that has TYPE text

        http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/reference/objects/obj_textrange.asp
*/
textArea_Event.prototype.onTextChange = function() {
   this.textArea_Event.storeCaret();

  var oEvent = window.event;
  var iKeyCode = oEvent.keyCode;
  if (iKeyCode == 110) { // Caractere : '.'
    this.textArea_Event.onChange();
  }
}

textArea_Event.prototype.onClick = function() {
  this.textArea_Event.storeCaret();
}

textArea_Event.prototype.onSelect = function() {
  this.textArea_Event.storeCaret();
}

textArea_Event.prototype.storeCaret = function() {
  if (this.oText.createTextRange) {
    this.oText.caretPos = document.selection.createRange().duplicate();
  }
}

textArea_Event.prototype.onChange = function() {
    if ( this.oText.isTextEdit && this.oText.caretPos ) {
      var bookmark = "~";
      var orig = this.oText.value;
      var caretPos = this.oText.caretPos;
      // Place la marque de position au niveau du curseur
      caretPos.text = bookmark;
      // Recherche la postion de la marque
      var pos = this.oText.value.search(bookmark);
      // Affiche dans la barre de status la postion du curseur
      window.status = "Caret is at character " + pos;
      // Re mets le texte d'origine
      this.oText.value = orig;
      // Décrémente le nombre de retour chario du nombre de caractères
      for(var i=0;i<pos;i++) {
        if (orig.charAt(i)=="\n")
          pos--;
      }
      // Positionne le curseur
      setCursorPosition(this.oText, pos, pos);
    }
    // Insertion du text à la postion actuelle
    insertAtCaret(this.oText, "Clicked");
}

/*
textArea_Event.prototype.insertAtCaret = function(text) {
*/
function insertAtCaret(lText, text) {
  lText.focus();
  if (lText.createTextRange) {
     var text;
     lText.focus(lText.caretPos);
     lText.caretPos = document.selection.createRange().duplicate();
     if(lText.caretPos.text.length>0) {
        //gère les espace de fin de sélection. Un double-click sélectionne le mot
        //+ un espace qu'on ne souhaite pas forcément...
        var sel = lText.caretPos.text;
        var fin = '';
        while(sel.substring(sel.length-1, sel.length)==' ') {
           sel = sel.substring(0, sel.length-1)
           fin += ' ';
        }
        lText.caretPos.text = sel + fin;
     }
     else
        lText.caretPos.text = text;
  }
  else lText.value += text;
}

function setCursorPosition(oInput,oStart,oEnd) {
   if( oInput.setSelectionRange ) {
     oInput.setSelectionRange(oStart,oEnd);
   }
   else if( oInput.createTextRange ) {
      var range = oInput.createTextRange();
      range.collapse(true);
      range.moveEnd('character',oEnd);
      range.moveStart('character',oStart);
      range.select();
   }
}
