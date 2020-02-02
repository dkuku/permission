
// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/landing.scss"
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
import "phoenix_html"

// Import local files
import 'alpinejs'
import "./navbar"

document.getElementById("globe").classList.add("invert")
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//$(function () {
//  $('html').addClass ( 'dom-loaded' );
//  $('<p>Appended with Cash</p>').appendTo ($('footer'));
//});
