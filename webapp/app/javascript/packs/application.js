/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


import Vue from 'vue';
import Feed from './Feed.vue';
import PageSelector from './PageSelector.vue';
import UserFeed from './UserFeed.vue';

window.Vue = Vue;
/* global $ */

/*
  This function discards all the arguments except the first.
  applying this using .then to the result of $.ajax has the effect of creating
  a new promise containing the resulting data.
*/
let dataOnly = r => r;

window.DataSource = {

    /* can be prepopulated with a resolved $.Deferred */
    sources: undefined,

    getSources() {
        this.sources = this.sources || $.getJSON('/feed/sources.json').then(dataOnly);
        return this.sources;
    },

    /* loads the posts, together with their source */
    getPosts(filter) {
        let rawPosts = $.getJSON('/feed/posts.json', filter).then(dataOnly);
        let enrichedResults = $.when(this.getSources(), rawPosts)
            .then((sources, posts) => {
                posts.forEach((post) => {
                    post['source'] = sources.find((s) => s.id == post['source_id']) || {};
                });
                return posts;
            });
        return enrichedResults;
    }
};

window.App = {
    Feed,
    PageSelector,
    UserFeed
};

export default window.App;