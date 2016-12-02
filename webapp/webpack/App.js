/*
* This file is set as webpack entrypoint
* it is compiled into the App.js in the /app/assets/javascripts folder
*
* The variables exported in this file will be available in the browser
*/

import Vue from 'vue';
import Feed from './Feed.vue';
import PageSelector from './PageSelector.vue';

window.Vue = Vue;
export default {Feed, PageSelector};
