/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 29);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

/* globals __VUE_SSR_CONTEXT__ */

// this module is a runtime utility for cleaner component module output and will
// be included in the final webpack user bundle

module.exports = function normalizeComponent (
  rawScriptExports,
  compiledTemplate,
  injectStyles,
  scopeId,
  moduleIdentifier /* server only */
) {
  var esModule
  var scriptExports = rawScriptExports = rawScriptExports || {}

  // ES6 modules interop
  var type = typeof rawScriptExports.default
  if (type === 'object' || type === 'function') {
    esModule = rawScriptExports
    scriptExports = rawScriptExports.default
  }

  // Vue.extend constructor export interop
  var options = typeof scriptExports === 'function'
    ? scriptExports.options
    : scriptExports

  // render functions
  if (compiledTemplate) {
    options.render = compiledTemplate.render
    options.staticRenderFns = compiledTemplate.staticRenderFns
  }

  // scopedId
  if (scopeId) {
    options._scopeId = scopeId
  }

  var hook
  if (moduleIdentifier) { // server build
    hook = function (context) {
      // 2.3 injection
      context =
        context || // cached call
        (this.$vnode && this.$vnode.ssrContext) || // stateful
        (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext) // functional
      // 2.2 with runInNewContext: true
      if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
        context = __VUE_SSR_CONTEXT__
      }
      // inject component styles
      if (injectStyles) {
        injectStyles.call(this, context)
      }
      // register component module identifier for async chunk inferrence
      if (context && context._registeredComponents) {
        context._registeredComponents.add(moduleIdentifier)
      }
    }
    // used by ssr in case component is cached and beforeCreate
    // never gets called
    options._ssrRegister = hook
  } else if (injectStyles) {
    hook = injectStyles
  }

  if (hook) {
    var functional = options.functional
    var existing = functional
      ? options.render
      : options.beforeCreate
    if (!functional) {
      // inject component registration as beforeCreate hook
      options.beforeCreate = existing
        ? [].concat(existing, hook)
        : [hook]
    } else {
      // register for functioal component in vue file
      options.render = function renderWithStyleInjection (h, context) {
        hook.call(context)
        return existing(h, context)
      }
    }
  }

  return {
    esModule: esModule,
    exports: scriptExports,
    options: options
  }
}


/***/ }),
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostCard_vue__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_15ddf425_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostCard_vue__ = __webpack_require__(4);
var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(2)
}
var normalizeComponent = __webpack_require__(0)
/* script */

/* template */

/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostCard_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_15ddf425_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostCard_vue__["a" /* default */],
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "app/javascript/packs/PostCard.vue"
if (Component.esModule && Object.keys(Component.esModule).some(function (key) {return key !== "default" && key.substr(0, 2) !== "__"})) {console.error("named exports are not supported in *.vue files.")}
if (Component.options.functional) {console.error("[vue-loader] PostCard.vue: functional components are not supported with templates, they should use render functions.")}

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-15ddf425", Component.options)
  } else {
    hotAPI.reload("data-v-15ddf425", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

/* harmony default export */ __webpack_exports__["default"] = (Component.exports);


/***/ }),
/* 2 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 3 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* global moment */

function postIcon(postType) {
    if (postType == 'link') return 'fa fa-link';
    if (postType == 'event') return 'fa fa-calendar';
    if (postType == 'photo') return "fa fa-photo";
    return "fa fa-sticky-note-o";
}

function postStyle(postType) {
    if (postType == 'link') return 'border-color: #FDD835;';
    if (postType == 'photo') return "border-color: #FFB300;";
    return "border-color: #AED581;";
}

var PostCard = {
    props: {
        post: Object
    },
    computed: {
        text: function text() {
            var content = this.post.content || "";
            var name = this.post.name ? this.post.name + " - " : "";
            return name + content;
        },
        time: function time() {
            return moment(this.post.created_at).format("L LT");
        },
        author_name: function author_name() {
            var name = this.post.author_name.split(" ");
            var first_name = name.shift();
            return first_name[0] + ". " + name.join(" ");
        },
        icon: function icon() {
            return postIcon(this.post.post_type);
        },
        style: function style() {
            return postStyle(this.post.post_type);
        }
    }
};

/* harmony default export */ __webpack_exports__["a"] = (PostCard);

/***/ }),
/* 4 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "post-card card post",
    style: (_vm.style),
    on: {
      "click": function($event) {
        _vm.$emit('click')
      }
    }
  }, [_c('div', {
    staticClass: "card-header"
  }, [_c('div', {
    staticClass: "row"
  }, [_c('div', {
    staticClass: "col-2 text-left"
  }, [_c('i', {
    class: _vm.icon
  })]), _vm._v(" "), _c('div', {
    staticClass: "col-10 text-right"
  }, [_vm._v("\n                " + _vm._s(_vm.time) + "\n            ")])])]), _vm._v(" "), (_vm.post.picture) ? _c('img', {
    staticClass: "card-img-top",
    attrs: {
      "src": _vm.post.picture,
      "alt": _vm.post.alt
    }
  }) : _vm._e(), _vm._v(" "), _c('div', {
    staticClass: "card-block"
  }, [_c('p', {
    staticClass: "card-text",
    staticStyle: {
      "word-wrap": "break-word"
    }
  }, [_vm._v(_vm._s(_vm.text))])]), _vm._v(" "), _c('div', {
    staticClass: "card-footer text-muted text-right"
  }, [_vm._v("\n        " + _vm._s(_vm.author_name) + "\n        "), _c('br'), _vm._v(" " + _vm._s(_vm.post.source.name) + " "), _c('img', {
    attrs: {
      "src": _vm.post.source.icon_link
    }
  }), _vm._v(" "), _c('hr'), _vm._v(" "), _c('div', {
    staticClass: "row"
  }, [_c('div', {
    staticClass: "col-12 text-right"
  }, [_vm._v("\n                " + _vm._s(_vm.post.likes) + " "), _c('i', {
    staticClass: "fa fa-thumbs-up"
  }), _vm._v(" " + _vm._s(_vm.post.comments) + " "), _c('i', {
    staticClass: "fa fa-comments"
  }), _vm._v(" " + _vm._s(_vm.post.shares) + " "), _c('i', {
    staticClass: "fa fa-share-alt"
  })])])])])
}
var staticRenderFns = []
render._withStripped = true
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);
if (false) {
  module.hot.accept()
  if (module.hot.data) {
     require("vue-hot-reload-api").rerender("data-v-15ddf425", esExports)
  }
}

/***/ }),
/* 5 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostModal_vue__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_38708fe8_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostModal_vue__ = __webpack_require__(8);
var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(6)
}
var normalizeComponent = __webpack_require__(0)
/* script */

/* template */

/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostModal_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_38708fe8_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostModal_vue__["a" /* default */],
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "app/javascript/packs/PostModal.vue"
if (Component.esModule && Object.keys(Component.esModule).some(function (key) {return key !== "default" && key.substr(0, 2) !== "__"})) {console.error("named exports are not supported in *.vue files.")}
if (Component.options.functional) {console.error("[vue-loader] PostModal.vue: functional components are not supported with templates, they should use render functions.")}

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-38708fe8", Component.options)
  } else {
    hotAPI.reload("data-v-38708fe8", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

/* harmony default export */ __webpack_exports__["default"] = (Component.exports);


/***/ }),
/* 6 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 7 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* global moment, $ */

function postIcon(postType) {
    if (postType == 'link') return 'fa fa-link';
    if (postType == 'event') return 'fa fa-calendar';
    if (postType == 'photo') return "fa fa-photo";
    return "fa fa-sticky-note-o";
}

var PostModal = {
    props: {
        post: Object
    },
    computed: {
        icon: function icon() {
            return postIcon(this.post.post_type);
        },
        time: function time() {
            return moment(this.post.created_at).format("L LT");
        }
    },
    methods: {
        show: function show() {
            $(this.$el).modal('show');
        }
    }
};

/* harmony default export */ __webpack_exports__["a"] = (PostModal);

/***/ }),
/* 8 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "modal fade",
    attrs: {
      "id": "post-modal",
      "tabindex": "-1",
      "role": "dialog",
      "aria-labelledby": "myModalLabel",
      "aria-hidden": "true"
    }
  }, [_c('div', {
    staticClass: "modal-dialog modal-lg",
    attrs: {
      "role": "document"
    }
  }, [_c('div', {
    staticClass: "modal-content"
  }, [_c('div', {
    staticClass: "modal-header"
  }, [_c('div', {
    staticClass: "col-6 text-left"
  }, [_c('a', {
    attrs: {
      "href": _vm.post.link,
      "target": "_blank"
    }
  }, [_c('i', {
    class: _vm.icon
  })])]), _vm._v(" "), _c('div', {
    staticClass: "col-6 text-right"
  }, [_c('a', {
    attrs: {
      "href": _vm.post.post_link,
      "target": "_blank"
    }
  }, [_vm._v(_vm._s(_vm.time))])])]), _vm._v(" "), _c('div', {
    staticClass: "modal-body"
  }, [_vm._v("\n                " + _vm._s(_vm.post.content) + "\n                "), _c('p', [_c('a', {
    attrs: {
      "href": _vm.post.link,
      "target": "_blank"
    }
  }, [(_vm.post.picture) ? _c('img', {
    staticClass: "mx-auto d-block img-fluid rounded",
    attrs: {
      "src": _vm.post.picture,
      "alt": _vm.post.alt
    }
  }) : _vm._e()])])]), _vm._v(" "), _c('div', {
    staticClass: "modal-footer"
  }, [_c('div', {
    staticClass: "col-6 text-left"
  }, [(_vm.post.author_link) ? _c('a', {
    attrs: {
      "href": _vm.post.author_link
    }
  }, [_vm._v(_vm._s(_vm.post.author_name))]) : _c('span', [_vm._v(" " + _vm._s(_vm.post.author_name))]), _vm._v(" @ " + _vm._s(_vm.post.source.name) + "\n                ")]), _vm._v(" "), _vm._m(0)])])])])
}
var staticRenderFns = [function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "col-6 text-right"
  }, [_c('button', {
    staticClass: "btn btn-secondary ",
    attrs: {
      "type": "button ",
      "data-dismiss": "modal"
    }
  }, [_vm._v("Close")])])
}]
render._withStripped = true
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);
if (false) {
  module.hot.accept()
  if (module.hot.data) {
     require("vue-hot-reload-api").rerender("data-v-38708fe8", esExports)
  }
}

/***/ }),
/* 9 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostDisplay_vue__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_060edebd_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostDisplay_vue__ = __webpack_require__(12);
var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(10)
}
var normalizeComponent = __webpack_require__(0)
/* script */

/* template */

/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_PostDisplay_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_060edebd_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_PostDisplay_vue__["a" /* default */],
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "app/javascript/packs/PostDisplay.vue"
if (Component.esModule && Object.keys(Component.esModule).some(function (key) {return key !== "default" && key.substr(0, 2) !== "__"})) {console.error("named exports are not supported in *.vue files.")}
if (Component.options.functional) {console.error("[vue-loader] PostDisplay.vue: functional components are not supported with templates, they should use render functions.")}

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-060edebd", Component.options)
  } else {
    hotAPI.reload("data-v-060edebd", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

/* harmony default export */ __webpack_exports__["default"] = (Component.exports);


/***/ }),
/* 10 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 11 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__PostCard_vue__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__PostModal_vue__ = __webpack_require__(5);
//
//
//
//
//
//
//


/* global Vue */




var PostDisplay = {
  props: {
    posts: Array
  },
  data: function data() {
    return {
      currentPost: null
    };
  },
  methods: {
    showModal: function showModal(post) {
      var _this = this;

      this.currentPost = post;
      Vue.nextTick(function () {
        _this.$refs.postModal.show();
      });
    }
  },
  components: {
    PostCard: __WEBPACK_IMPORTED_MODULE_0__PostCard_vue__["default"],
    PostModal: __WEBPACK_IMPORTED_MODULE_1__PostModal_vue__["default"]
  }
};

/* harmony default export */ __webpack_exports__["a"] = (PostDisplay);

/***/ }),
/* 12 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: "post-display"
  }, [_vm._l((_vm.posts), function(p) {
    return _c('PostCard', {
      key: p.id,
      attrs: {
        "post": p
      },
      on: {
        "click": function($event) {
          _vm.showModal(p)
        }
      }
    })
  }), _vm._v(" "), (_vm.currentPost) ? _c('PostModal', {
    ref: "postModal",
    attrs: {
      "post": _vm.currentPost
    }
  }) : _vm._e()], 2)
}
var staticRenderFns = []
render._withStripped = true
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);
if (false) {
  module.hot.accept()
  if (module.hot.data) {
     require("vue-hot-reload-api").rerender("data-v-060edebd", esExports)
  }
}

/***/ }),
/* 13 */,
/* 14 */,
/* 15 */,
/* 16 */,
/* 17 */,
/* 18 */,
/* 19 */,
/* 20 */,
/* 21 */,
/* 22 */,
/* 23 */,
/* 24 */,
/* 25 */,
/* 26 */,
/* 27 */,
/* 28 */,
/* 29 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_UserFeed_vue__ = __webpack_require__(31);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_00695fde_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_UserFeed_vue__ = __webpack_require__(32);
var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(30)
}
var normalizeComponent = __webpack_require__(0)
/* script */

/* template */

/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_UserFeed_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_00695fde_hasScoped_false_node_modules_vue_loader_lib_selector_type_template_index_0_UserFeed_vue__["a" /* default */],
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "app/javascript/packs/UserFeed.vue"
if (Component.esModule && Object.keys(Component.esModule).some(function (key) {return key !== "default" && key.substr(0, 2) !== "__"})) {console.error("named exports are not supported in *.vue files.")}
if (Component.options.functional) {console.error("[vue-loader] UserFeed.vue: functional components are not supported with templates, they should use render functions.")}

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-00695fde", Component.options)
  } else {
    hotAPI.reload("data-v-00695fde", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

/* harmony default export */ __webpack_exports__["default"] = (Component.exports);


/***/ }),
/* 30 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 31 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__PostDisplay_vue__ = __webpack_require__(9);
//
//
//
//
//
//



/* Main app
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

/* global DataSource, console */

var UserFeed = {
    data: function data() {
        return {
            filter: {
                sources: "",
                author: 0,
                limit: 0
            },
            posts: []
        };
    },
    mounted: function mounted() {
        this.updatePosts();
    },
    methods: {
        updatePosts: function updatePosts() {
            var _this = this;

            DataSource.getPosts(this.filter).then(function (posts) {
                _this.posts = posts;
            });
        }
    },
    components: {
        PostDisplay: __WEBPACK_IMPORTED_MODULE_0__PostDisplay_vue__["default"]
    }
};

/* harmony default export */ __webpack_exports__["a"] = (UserFeed);

/***/ }),
/* 32 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    attrs: {
      "id": "feedapp"
    }
  }, [_c('PostDisplay', {
    attrs: {
      "posts": _vm.posts
    }
  })], 1)
}
var staticRenderFns = []
render._withStripped = true
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);
if (false) {
  module.hot.accept()
  if (module.hot.data) {
     require("vue-hot-reload-api").rerender("data-v-00695fde", esExports)
  }
}

/***/ })
/******/ ]);