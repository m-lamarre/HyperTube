$(window).on('load', function() {
  if ($('#my_player').length) {
    url = window.location.href
    download_url = url.replace('/movie/play', '/api/v1') + '/download_url';
    console.log(download_url);
    ret = $.ajax({
      url: download_url,
      type: 'GET',
      success:  function(data) {
        console.log(data);
        videojs('my_player').src({ type: 'video/mp4', src: data });
      },
      error: function(data) {
        alert('it flopped')
        console.log(data);
        videojs('my_player').src({ type: 'video/mp4', src: data.responseText });
      }
    });
  }
});
