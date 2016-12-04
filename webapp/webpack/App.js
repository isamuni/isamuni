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

  getSources(){
    this.sources = this.sources || $.getJSON('/feed/sources.json').then(dataOnly);
    return this.sources;
  },

  /* loads the posts, together with their source */
  getPosts(filter){
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

export default {Feed, PageSelector};
