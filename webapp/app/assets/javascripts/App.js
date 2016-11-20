var App =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmory imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmory exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		Object.defineProperty(exports, name, {
/******/ 			configurable: false,
/******/ 			enumerable: true,
/******/ 			get: getter
/******/ 		});
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/assets/";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports) {

eval("throw new Error(\"Module build failed: Error: Cannot find module '../modules/web.dom.iterable'\\n    at Function.Module._resolveFilename (module.js:472:15)\\n    at Function.Module._load (module.js:420:25)\\n    at Module.require (module.js:500:17)\\n    at require (internal/module.js:20:19)\\n    at Object.<anonymous> (/Users/sic2/repos/isamuni/webapp/node_modules/babel-core/node_modules/babel-runtime/node_modules/core-js/library/fn/get-iterator.js:1:63)\\n    at Module._compile (module.js:573:32)\\n    at Object.Module._extensions..js (module.js:582:10)\\n    at Module.load (module.js:490:32)\\n    at tryModuleLoad (module.js:449:12)\\n    at Function.Module._load (module.js:441:3)\\n    at Module.require (module.js:500:17)\\n    at require (internal/module.js:20:19)\\n    at Object.<anonymous> (/Users/sic2/repos/isamuni/webapp/node_modules/babel-core/node_modules/babel-runtime/core-js/get-iterator.js:1:93)\\n    at Module._compile (module.js:573:32)\\n    at Object.Module._extensions..js (module.js:582:10)\\n    at Module.load (module.js:490:32)\\n    at tryModuleLoad (module.js:449:12)\\n    at Function.Module._load (module.js:441:3)\\n    at Module.require (module.js:500:17)\\n    at require (internal/module.js:20:19)\\n    at Object.<anonymous> (/Users/sic2/repos/isamuni/webapp/node_modules/babel-core/lib/transformation/file/index.js:10:21)\\n    at Module._compile (module.js:573:32)\\n    at Object.Module._extensions..js (module.js:582:10)\\n    at Module.load (module.js:490:32)\\n    at tryModuleLoad (module.js:449:12)\\n    at Function.Module._load (module.js:441:3)\\n    at Module.require (module.js:500:17)\\n    at require (internal/module.js:20:19)\\n    at Object.<anonymous> (/Users/sic2/repos/isamuni/webapp/node_modules/babel-core/lib/api/node.js:6:13)\\n    at Module._compile (module.js:573:32)\");\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiIwLmpzIiwic291cmNlUm9vdCI6IiJ9");

/***/ }
/******/ ]);