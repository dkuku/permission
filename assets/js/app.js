import css from "../css/app.scss"
import 'alpinejs'
// Import local files
import "./navbar"
import "phoenix_html"
//
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}});

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket

import NProgress from "nprogress"

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

//import { dom, library } from '@fortawesome/fontawesome-svg-core'
//import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'
//import { faEye, faEdit } from '@fortawesome/free-regular-svg-icons'
//import { } from '@fortawesome/free-brands-svg-icons'
//library.add(faTrashAlt, faEdit, faEye)
//dom.i2svg()
//  .then(function () {
//    console.log('Icons have rendered')
//})

