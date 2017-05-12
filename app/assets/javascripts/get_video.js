$(window).on('load', function() {
  if ($('#movie').length) {
    $('.movie-container').css('display', 'none')
    get_movie_url();
  }
});

function get_movie_url() {
  url = window.location.href
  api_url = url.replace('/movie/play', '/api/v1') + '/download_url';
  $.ajax({
    url: api_url,
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
