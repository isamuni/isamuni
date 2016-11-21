var path = require('path')
var webpack = require('webpack')

module.exports = {
  entry: './webpack/App.js',
  output: {
    path: path.resolve(__dirname, './app/assets/javascripts/'),
    publicPath: '/assets/',
    filename: 'App.js',
    libraryTarget: "var",
    library: "App"

  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          // vue-loader options go here
        }
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]?[hash]'
        }
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue'
    }
  },
  devServer: {
    noInfo: true,
    proxy: {
      '/': {
        target: 'http://squirrels.vii.ovh:3000/',
        secure: false,
        port: 3000,
        bypass: function(req, res, proxyOptions) {
          if(req.url.startsWith("/assets/App.")){
            console.log("Bypassing proxy for " + req.url);
            return "/assets/App.js"
          }
          return false;
        }
      }
    }
  },
  devtool: '#eval-source-map'
}

if (process.env.NODE_ENV === 'production') {
  module.exports.devtool = '#source-map'
  // http://vue-loader.vuejs.org/en/workflow/production.html
  module.exports.plugins = (module.exports.plugins || []).concat([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new webpack.LoaderOptionsPlugin({
      minimize: true
    })
  ])
}
