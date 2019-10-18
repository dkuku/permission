const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const PurgecssPlugin = require('purgecss-webpack-plugin');

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
        paths: glob.sync('../lib/workpermit_web/templates/**/*.html.eex'),
        extractors: [
          {
            extractor: TailwindExtractor,
            extensions: ['html', 'js', 'eex'],
          },
        ],
        whitelist: ['.markdown']
      }),
    ]
  },
  entry: {
      './js/app.js': ['./js/app.js'].concat(glob.sync('./vendor/**/*.js'))
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
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
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
  ]
});
