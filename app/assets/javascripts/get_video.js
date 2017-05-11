$(window).on('load', function() {
  if ($('#movie').length) {
    $('.movie-container').css('display', 'none')
    url = window.location.href
    download_url = url.replace('/movie/play', '/api/v1') + '/download_url';
    console.log(download_url);
    get_movie_url();
  }
});

function get_movie_url() {
  $.ajax({
    url: download_url,
    type: 'GET',
    success:  function(data) {
      if (data['error']) {
        get_movie_url();
      }
    },
    error: function(data) {
      $('.movie-container').css('display', 'block')
      $('.loading-container').css('display', 'none')
      videojs('movie').src({ type: 'video/mp4', src: data.responseText });
    }
  });
}
