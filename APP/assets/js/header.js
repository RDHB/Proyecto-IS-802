(function($) {
	var $body = $('body');
	// Header (narrower + mobile).
	// Toggle.
	$(
		'<div id="headerToggle" onclick="mostrarHeader()">' +
			'<a href="#header" class="toggle"></a>' +
		'</div>'
	).appendTo($body);
})(jQuery);

function mostrarHeader() {
	if (document.querySelector("body.header-visible")) {
		$( 'body' ).removeClass( "header-visible" );
	} else {
		$( 'body' ).addClass( "header-visible" );
	}
}
