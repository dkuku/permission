// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
import "phoenix_html"
import 'alpinejs'

// Import local files
import "./navbar"
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import { dom, library } from '@fortawesome/fontawesome-svg-core'
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'
import { faEye, faEdit } from '@fortawesome/free-regular-svg-icons'
import { } from '@fortawesome/free-brands-svg-icons'
library.add(faTrashAlt, faEdit, faEye)
dom.i2svg()
  .then(function () {
    console.log('Icons have rendered')
})
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}});

liveSocket.connect()
//
//$(function () {
//  $('html').addClass ( 'dom-loaded' );
//  $('<p>Appended with Cash</p>').appendTo ($('footer'));
//});
