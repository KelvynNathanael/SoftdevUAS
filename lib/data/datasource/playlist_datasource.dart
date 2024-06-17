import 'package:mobile/data/model/playlist.dart';
import 'package:mobile/data/model/playlist_track.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/services/music_operations.dart';

abstract class PlaylistDatasource {
  Future<Playlist> trackList(String mix);
}

class PLaylistLocalDatasource extends PlaylistDatasource {
  @override
  Future<Playlist> trackList(String mix) async {
    List<String> trackIds = [];

    // Assign trackIds based on the mix
    if (mix == "Drake mix") {
      trackIds = [
        '466cKvZn1j45IpxDdYZqdA',
        '7sO5G9EABYOXQKNPNiE9NR',
        '1zi7xx7UVEFkmKfv06H8x0',
        '7GX5flRQZVHRAGd6B4TmDO',
        '6DCZcSspjsKoFjzjrWoCdn',
        '3B54sVLJ402zGa6Xm4YGNe',
        '3F5CgOj3wFlRv51JsHbxhe',
        '3CA9pLiwRIGtUBiMjbZmRw',
        '0TlLq3lA83rQOYtrqBqSct',
        '1zgHn1EqUyA0HqNYMdJ5ia',
        '72TFWvU3wUYdUuxejTTIzt',
        '6Kj17Afjo1OKJYpf5VzCeo',
        '1tkg4EHVoqnhR6iFEXb60y',
        '43PuMrRfbyyuz4QpZ3oAwN',
        '74tLlkN3rgVzRqQJgPfink',
      ];
    } else if (mix == "Upbeat") {
      trackIds = [
        '6ebkx7Q5tTxrCxKq4GYj0Y',
        '2M3g1eQZvnmsi8iMESZYY9',
        '5nujrmhLynf4yMoMtj8AQF',
        '4cluDES4hQEUhmXj6TXkSo',
        '1PSBzsahR2AKwLJgx8ehBj',
        '2BgEsaKNfHUdlh97KmvFyo',
        '2bT1PH7Cw3J9p3t7nlXCdh',
        '3P3pw6C19j31Rnzgo3JG7o',
        '2qQpFbqqkLOGySgNK8wBXt',
        '6PCUP3dWmTjcTtXY02oFdT',
        '7npLlaPu9Mfno8hjk5OagD',
        '6jjYDGxVJsWS0a5wlVF5vS',
        '7BKLCZ1jbUBVqRi2FVlTVw',
        '4ZtFanR9U6ndgddUvNcjcG',
        '2P4OICZRVAQcYAV2JReRfj',
      ];
    } else if (mix == "Chill") {
      trackIds = [
        '1IX47gefluXmKX4PrTBCRM',
        '0doLJjIDrYkoXDb4b9Qa8n',
        '2S1LebN6AXXQqJolBxlWgO',
        '6MczIMSdoZyw8EBPhihazN',
        '3R7e2jGs4kNDvkzEvqcnsc',
        '14AgBbjVYu2l5vWvbb9XVi',
        '0GuEv8le1mXsKzx6xBiARx',
        '7JQeu7AyFO2Pt8tsNdSUFW',
        '2FML7gk7ac6quGFIjvkDb3',
        '5FahFQNnmxqiWzJbDNmeIY',
        '3khEEPRyBeOUabbmOPJzAG',
        '3kK8euC9eUBRwZKpMsQsDZ',
        '0ShUHmWaz48KgyjaOG7Tpv',
        '6wmAHw1szh5RCKSRjiXhPe',
        '1ep7teyCvaVdPDhxS2Xr0S',
      ];
    } else if (mix == "2010") {
      trackIds = [
        '47Slg6LuqLaX0VodpSCvPt',
        '0SiywuOBRcynK0uKGWdCnn',
        '20I6sIOMTCkB6w7ryavxtO',
        '0tJGzJjUVlEsn8s3Mn32Jb',
        '2iuZJX9X9P0GKaE93xcPjk',
        '6ECp64rv50XVz93WvxXMGF',
        '6yARPLK0PV4heEyh7pVMGz',
        '4HlFJV71xXKIGcU3kRyttv',
        '65YsalQBmQCzIPaay72CzQ',
        '3rfhI32Il2hVRKDkuGeeen',
        '2iUmqdfGZcHIhS3b9E9EWq',
        '5O2P9iiztwhomNh8xkR9lJ',
        '235LXPXfi0SmOaS9TaCh3c',
        '5jE48hhRu8E6zBDPRSkEq7',
        '6Rb0ptOEjBjPPQUlQtQGbL',
      ];
    } else if (mix == "baby keem") {
      trackIds = [
        '47Slg6LuqLaX0VodpSCvPt',
        '0SiywuOBRcynK0uKGWdCnn',
        '20I6sIOMTCkB6w7ryavxtO',
        '0tJGzJjUVlEsn8s3Mn32Jb',
        '2iuZJX9X9P0GKaE93xcPjk',
        '6ECp64rv50XVz93WvxXMGF',
        '6yARPLK0PV4heEyh7pVMGz',
        '4HlFJV71xXKIGcU3kRyttv',
        '65YsalQBmQCzIPaay72CzQ',
        '3rfhI32Il2hVRKDkuGeeen',
        '2iUmqdfGZcHIhS3b9E9EWq',
        '5O2P9iiztwhomNh8xkR9lJ',
        '235LXPXfi0SmOaS9TaCh3c',
        '5jE48hhRu8E6zBDPRSkEq7',
        '6Rb0ptOEjBjPPQUlQtQGbL',
      ];
    } else if (mix == "future mix") {
      trackIds = [
        '466cKvZn1j45IpxDdYZqdA',
        '7sO5G9EABYOXQKNPNiE9NR',
        '1zi7xx7UVEFkmKfv06H8x0',
        '7GX5flRQZVHRAGd6B4TmDO',
        '6DCZcSspjsKoFjzjrWoCdn',
        '3B54sVLJ402zGa6Xm4YGNe',
        '3F5CgOj3wFlRv51JsHbxhe',
        '3CA9pLiwRIGtUBiMjbZmRw',
        '0TlLq3lA83rQOYtrqBqSct',
        '1zgHn1EqUyA0HqNYMdJ5ia',
        '72TFWvU3wUYdUuxejTTIzt',
        '6Kj17Afjo1OKJYpf5VzCeo',
        '1tkg4EHVoqnhR6iFEXb60y',
        '43PuMrRfbyyuz4QpZ3oAwN',
        '74tLlkN3rgVzRqQJgPfink',
      ];
    } else if (mix == "Kendrick Lamar mix") {
      trackIds = [
        '1IX47gefluXmKX4PrTBCRM',
        '0doLJjIDrYkoXDb4b9Qa8n',
        '2S1LebN6AXXQqJolBxlWgO',
        '6MczIMSdoZyw8EBPhihazN',
        '3R7e2jGs4kNDvkzEvqcnsc',
        '14AgBbjVYu2l5vWvbb9XVi',
        '0GuEv8le1mXsKzx6xBiARx',
        '7JQeu7AyFO2Pt8tsNdSUFW',
        '2FML7gk7ac6quGFIjvkDb3',
        '5FahFQNnmxqiWzJbDNmeIY',
        '3khEEPRyBeOUabbmOPJzAG',
        '3kK8euC9eUBRwZKpMsQsDZ',
        '0ShUHmWaz48KgyjaOG7Tpv',
        '6wmAHw1szh5RCKSRjiXhPe',
        '1ep7teyCvaVdPDhxS2Xr0S',
      ];
    } else if (mix == "Travis Scott mix") {
      trackIds = [
        '6ebkx7Q5tTxrCxKq4GYj0Y',
        '2M3g1eQZvnmsi8iMESZYY9',
        '5nujrmhLynf4yMoMtj8AQF',
        '4cluDES4hQEUhmXj6TXkSo',
        '1PSBzsahR2AKwLJgx8ehBj',
        '2BgEsaKNfHUdlh97KmvFyo',
        '2bT1PH7Cw3J9p3t7nlXCdh',
        '3P3pw6C19j31Rnzgo3JG7o',
        '2qQpFbqqkLOGySgNK8wBXt',
        '6PCUP3dWmTjcTtXY02oFdT',
        '7npLlaPu9Mfno8hjk5OagD',
        '6jjYDGxVJsWS0a5wlVF5vS',
        '7BKLCZ1jbUBVqRi2FVlTVw',
        '4ZtFanR9U6ndgddUvNcjcG',
        '2P4OICZRVAQcYAV2JReRfj',
      ];
    } else if (mix == "JID mix") {
      trackIds = [
        '6ebkx7Q5tTxrCxKq4GYj0Y',
        '2M3g1eQZvnmsi8iMESZYY9',
        '5nujrmhLynf4yMoMtj8AQF',
        '4cluDES4hQEUhmXj6TXkSo',
        '1PSBzsahR2AKwLJgx8ehBj',
        '2BgEsaKNfHUdlh97KmvFyo',
        '2bT1PH7Cw3J9p3t7nlXCdh',
        '3P3pw6C19j31Rnzgo3JG7o',
        '2qQpFbqqkLOGySgNK8wBXt',
        '6PCUP3dWmTjcTtXY02oFdT',
        '7npLlaPu9Mfno8hjk5OagD',
        '6jjYDGxVJsWS0a5wlVF5vS',
        '7BKLCZ1jbUBVqRi2FVlTVw',
        '4ZtFanR9U6ndgddUvNcjcG',
        '2P4OICZRVAQcYAV2JReRfj',
      ];
    } else if (mix == "21 Savage mix") {
      trackIds = [
        '6ebkx7Q5tTxrCxKq4GYj0Y',
        '2M3g1eQZvnmsi8iMESZYY9',
        '5nujrmhLynf4yMoMtj8AQF',
        '4cluDES4hQEUhmXj6TXkSo',
        '1PSBzsahR2AKwLJgx8ehBj',
        '2BgEsaKNfHUdlh97KmvFyo',
        '2bT1PH7Cw3J9p3t7nlXCdh',
        '3P3pw6C19j31Rnzgo3JG7o',
        '2qQpFbqqkLOGySgNK8wBXt',
        '6PCUP3dWmTjcTtXY02oFdT',
        '7npLlaPu9Mfno8hjk5OagD',
        '6jjYDGxVJsWS0a5wlVF5vS',
        '7BKLCZ1jbUBVqRi2FVlTVw',
        '4ZtFanR9U6ndgddUvNcjcG',
        '2P4OICZRVAQcYAV2JReRfj',
      ];
    } else if (mix == "liked song") {
      // Use GlobalPlayerState.likes for the "liked song" mix
      trackIds = GlobalPlayerState.likes;
    }
    // Add more conditions for other mixes if necessary

    // Get PlaylistTracks dynamically using MusicOperations
    List<PLaylistTrack> playlistTracks = await MusicOperations.getPlaylistTracks(trackIds);

    // Return Playlist object with dynamically fetched tracks
    return Playlist(mix, playlistTracks);
  }
}