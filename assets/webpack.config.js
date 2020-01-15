const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const PurgecssPlugin = require('purgecss-webpack-plugin');
const globAll = require('glob-all');

class TailwindExtractor {
  static extract(content) {
    return content.match(/[A-Za-z0-9-_:\/]+/g) || [];
  }
}

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin(),
      new OptimizeCSSAssetsPlugin({}),
      new PurgecssPlugin({
        paths: globAll.sync([
            '../lib/web/templates/**/*.html.eex',
            '../lib/web/views/**/*.ex',
            '../lib/web/live/**/*.ex',
            '../assets/js/**/*.js',
          ]),
        extractors: [
          {
            extractor: TailwindExtractor,
            extensions: ['html', 'js', 'eex', 'ex'],
          },
        ],
        whitelist: ['.markdown', '.awesomplete']
      }),
    ]
  },
  entry: {
      'app': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js')),
      'landing': ['./js/landing.js'],
      'multi_step_form': ['./js/multi_step_form.js'],
  },
  resolve: {
    alias: {
      svelte: path.resolve('node_modules', 'svelte')
    },
    extensions: ['.mjs', '.js', '.svelte'],
    mainFields: ['svelte', 'browser', 'module', 'main'],
    modules: ['node_modules']
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        },
      },
      {
        test: /\.mjs$/,
        include: /node_modules/,
        type: "javascript/auto",
      },
      {
        test: /\.(html|svelte)$/,
        exclude: /node_modules/,
        use: {
          loader: 'svelte-loader',
          options: {
            hotReload: true
          }
        }
      },
      { test: /\.(gif|png|jpe?g|svg)$/i,
        use: [
          'file-loader',
          {
            loader: 'image-webpack-loader',
            options: {
              mozjpeg: {
                progressive: true,
                quality: 65
              },
              // optipng.enabled: false will disable optipng
              optipng: {
              },
              svgo: {
                options: {
                  plugins: [
                    {removeTitle: true},
                    {convertColors: {shorthex: true}},
                    {convertPathData: false}
                  ]
                }
              },
              pngquant: {
                quality: [0.65, 0.90],
                speed: 4
              },
              gifsicle: {
                interlaced: false,
              },
              // the webp option will enable WEBP
              webp: {
                quality: 75
              }
            }
          },
        ],
      },
            {
              test: /\.(css|sass|scss)$/,
              use: [MiniCssExtractPlugin.loader, 'css-loader', 'postcss-loader']
              //use: [
              //  MiniCssExtractPlugin.loader,
              //  { loader: 'css-loader'},
              //  { loader: 'postcss-loader'}
              //]
            }
          ]
        },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
  ]
});
