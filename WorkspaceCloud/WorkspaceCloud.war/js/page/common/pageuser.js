
	function form_unload() {
    self.opener.refresh()
	}

	function form_submit(aForm) {
//		aForm.submit();
//		self.opener.refresh();
//		self.close();
		window.close();
		return true;
	}
