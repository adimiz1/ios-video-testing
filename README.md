
# iOS-Video-Testing

This app is meant to show how to build a video player feed using `CLDVideoPlayer` from [Cloudinary iOS SDK](https://github.com/cloudinary/cloudinary_ios)
Things to notice:
* Duration is taken asynchronously to prevent from blocking the UI thread.
* We detect visible cells to select which videos to play and which to pause.
* 
