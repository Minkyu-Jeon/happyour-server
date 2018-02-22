(function() {
	$("#curation-table").on("change", "input[type='checkbox']", function(e) {
		var checked = this.checked;
		var title = $(this).closest("tr").find("[data-title]").text();
		var $ul = $("#selected-stores");
		var id = $(this).val();

		if ( checked ) {
			$ul.append("<li data-store-id='"+id+"'>"+ title +"</li>");
		} else {
			$ul.find("[data-store-id='"+id+"']").remove()
		}
	});
	$("#curation-table input[type='checkbox']").trigger("change")
})();