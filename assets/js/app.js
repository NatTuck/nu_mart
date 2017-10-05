// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

//  $("body") -> [every "body" tag in the page]
//  $(".foo") -> [every HTML element with class "foo"]
//  $("#reviews-template") -> [every HTML elem with id = "reviews-template"]

let handlebars = require("handlebars");

$(function() {
  if (!$("#reviews-template").length > 0) {
    // Wrong page.
    return;
  }

  let tt = $($("#reviews-template")[0]);
  let code = tt.html();
  let tmpl = handlebars.compile(code);

  let dd = $($("#product-reviews")[0]);
  let path = dd.data('path');
  let p_id = dd.data('product_id');

  let bb = $($("#review-add-button")[0]);
  let u_id = bb.data('user-id');

  function fetch_reviews() {
    function got_reviews(data) {
      console.log(data);
      let html = tmpl(data);
      dd.html(html);
    }

    $.ajax({
      url: path,  // # "/api/v1/reviews"
      data: {product_id: p_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_reviews,
    });
  }

  function add_review() {
    let comment = $("#review-comment").val();

    let data = {review: {product_id: p_id, user_id: u_id, stars: 3, comment: comment}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_reviews,
    });

    $("#review-comment").val("");
  }

  bb.click(add_review);

  fetch_reviews();
});

