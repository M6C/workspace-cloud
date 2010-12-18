	function CheckUncheck() {
		var cbxCount = document.getElementsByName('cbxCount')[0].value;
		var i=1;
		for(i=1 ; i<=cbxCount ; i++) {
			var cbx = document.getElementsByName('cbxTable'+i)[0];
			if (typeof(cbx)!="undefined") {
				cbx.checked = !cbx.checked;
			}
		}
	}
