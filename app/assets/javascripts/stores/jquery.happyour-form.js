(function() {
	$.fn.happyourForm = function() {
		return $(this).each(function() {
			var me = $(this);

			$(this).find(".edit-happyour").on("click", function(e) {
				e.preventDefault();
				var $el = $(this);
				var $tr = $el.closest("tr")
				var dayOfWeek = $tr.data("day-of-week");
				var $form = $tr.find(".td-form");
				
				var storeId = me.data("store-id");
				var mode = $el.find("i").hasClass("fa-edit") ? "edit" : "submit";
				$el.find("i").toggleClass("fa-edit fa-check")				

				if ( mode == "edit" ) {
					$form.find(".content").hide()
					$.ajax({
						url: "/stores/" + storeId + "/happyhours/bulk_edit",
						data: {day_of_week: dayOfWeek},
						method: "GET",
						dataType: "JSON"
					}).done(function(e) {
						$form.find(".form").html(e.html)
						$form.find(".form").show()
					});
				} else {
					$form.find(".form").hide()
					$.ajax({
						url: "/stores/" + storeId + "/happyhours/bulk_update",
						data: $form.find("form").serialize(),
						method: "POST",
						dataType: "JSON"
					}).done(function(e) {
						$form.find(".content").html(e.html)
						$form.find(".content").show()
					});
				}
			});
			$(this).on("click", ".remove", function(e) {
				e.preventDefault();
				var $el = $(this);
				var $formGroup = $el.closest(".form-group");
				$formGroup.append("<input type='hidden' name='happyhour[][_destroy]' value='1'>")
				$formGroup.hide();
			}).on("click", ".plus", function(e) {
				e.preventDefault();
				var $el = $(this);
				var $form = $el.closest(".form");
				var dayOfWeek = $form.closest("tr").data("day-of-week")
				var html = ""
				html += "<div class='form-group'>"
				html += "<input type='hidden' name='happyhour[][id]'> "
				html += "<input type='text' name='happyhour[][start_time]' class='form-control inline-block width-120px'> "
				html += "<input type='text' name='happyhour[][end_time]' class='form-control inline-block width-120px'> "
				html += "<input type='hidden' name='happyhour[][day_of_week]' value='"+dayOfWeek+"' >"
				html += "<a href='#' class='remove'><i class='fa fa-trash'></i></a>"
				html += "</div>"
				$el.before(html)
			}).on("click", ".set-holiday", function(e) {
				if ( confirm("정말 휴일로 지정하시겠습니까?") ) {
					var $el = $(this);
					var storeId = me.data("store-id");
					var dayOfWeek = $el.closest("tr").data("day-of-week")
					$.ajax({
						url: "/stores/" + storeId + "/happyhours/set_holiday",
						data: {day_of_week: dayOfWeek},
						method: "POST",
						dataType: "JSON"
					}).done(function(e) {
						if ( e.result ) {
							alert("휴일로 설정되었습니다.")
							location.reload();	
						}
					});
				}
			});

		});

	};
})();