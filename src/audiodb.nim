# Copyright 2022 XXIV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import httpClient
import strformat
import strutils
import uri
import options
import json

type
  Artist* = object
    idArtist* : string
    strArtist* : string
    strArtistStripped* : string
    strArtistAlternate* : string
    strLabel* : string
    idLabel* : string
    intFormedYear* : string
    intBornYear* : string
    intDiedYear* : string
    strDisbanded* : string
    strStyle* : string
    strGenre* : string
    strMood* : string
    strWebsite* : string
    strFacebook* : string
    strTwitter* : string
    strBiographyEN* : string
    strBiographyDE* : string
    strBiographyFR* : string
    strBiographyCN* : string
    strBiographyIT* : string
    strBiographyJP* : string
    strBiographyRU* : string
    strBiographyES* : string
    strBiographyPT* : string
    strBiographySE* : string
    strBiographyNL* : string
    strBiographyHU* : string
    strBiographyNO* : string
    strBiographyIL* : string
    strBiographyPL* : string
    strGender* : string
    intMembers* : string
    strCountry* : string
    strCountryCode* : string
    strArtistThumb* : string
    strArtistLogo* : string
    strArtistCutout* : string
    strArtistClearart* : string
    strArtistWideThumb* : string
    strArtistFanart* : string
    strArtistFanart2* : string
    strArtistFanart3* : string
    strArtistFanart4* : string
    strArtistBanner* : string
    strMusicBrainzID* : string
    strISNIcode* : string
    strLastFMChart* : string
    intCharted* : string
    strLocked* : string

type
  Discography* = object
    strAlbum* : string
    intYearReleased* : string

type
  Album* = object
    idAlbum* : string
    idArtist* : string
    idLabel* : string
    strAlbum* : string
    strAlbumStripped* : string
    strArtist* : string
    strArtistStripped* : string
    intYearReleased* : string
    strStyle* : string
    strGenre* : string
    strLabel* : string
    strReleaseFormat* : string
    intSales* : string
    strAlbumThumb* : string
    strAlbumThumbHQ* : string
    strAlbumThumbBack* : string
    strAlbumCDart* : string
    strAlbumSpine* : string
    strAlbum3DCase* : string
    strAlbum3DFlat* : string
    strAlbum3DFace* : string
    strAlbum3DThumb* : string
    strDescriptionEN* : Option[string]
    strDescriptionDE* : string
    strDescriptionFR* : string
    strDescriptionCN* : string
    strDescriptionIT* : string
    strDescriptionJP* : string
    strDescriptionRU* : string
    strDescriptionES* : string
    strDescriptionPT* : string
    strDescriptionSE* : string
    strDescriptionNL* : string
    strDescriptionHU* : string
    strDescriptionNO* : string
    strDescriptionIL* : string
    strDescriptionPL* : string
    intLoved* : string
    intScore* : string
    intScoreVotes* : string
    strReview* : string
    strMood* : string
    strTheme* : string
    strSpeed* : string
    strLocation* : string
    strMusicBrainzID* : string
    strMusicBrainzArtistID* : string
    strAllMusicID* : string
    strBBCReviewID* : string
    strRateYourMusicID* : string
    strDiscogsID* : string
    strWikidataID* : string
    strWikipediaID* : string
    strGeniusID* : string
    strLyricWikiID* : string
    strMusicMozID* : string
    strItunesID* : string
    strAmazonID* : string
    strLocked* : string

type
  Track* = object
    idTrack* : string
    idAlbum* : string
    idArtist* : string
    idLyric* : string
    idIMVDB* : string
    strTrack* : string
    strAlbum* : string
    strArtist* : string
    strArtistAlternate* : string
    intCD* : string
    intDuration* : string
    strGenre* : string
    strMood* : string
    strStyle* : string
    strTheme* : string
    strDescriptionEN* : string
    strDescriptionDE* : string
    strDescriptionFR* : string
    strDescriptionCN* : string
    strDescriptionIT* : string
    strDescriptionJP* : string
    strDescriptionRU* : string
    strDescriptionES* : string
    strDescriptionPT* : string
    strDescriptionSE* : string
    strDescriptionNL* : string
    strDescriptionHU* : string
    strDescriptionNO* : string
    strDescriptionIL* : string
    strDescriptionPL* : string
    strTrackThumb* : string
    strTrack3DCase* : string
    strTrackLyrics* : string
    strMusicVid* : string
    strMusicVidDirector* : string
    strMusicVidCompany* : string
    strMusicVidScreen1* : string
    strMusicVidScreen2* : string
    strMusicVidScreen3* : string
    intMusicVidViews* : string
    intMusicVidLikes* : string
    intMusicVidDislikes* : string
    intMusicVidFavorites* : string
    intMusicVidComments* : string
    intTrackNumber* : string
    intLoved* : string
    intScore* : string
    intScoreVotes* : string
    intTotalListeners* : string
    intTotalPlays* : string
    strMusicBrainzID* : string
    strMusicBrainzAlbumID* : string
    strMusicBrainzArtistID* : string
    strLocked* : string

type
  MusicVideo* = object
    idArtist* : string
    idAlbum* : string
    idTrack* : string
    strTrack* : string
    strTrackThumb* : string
    strMusicVid* : string
    strDescriptionEN* : string


type
  AudioDBException* = object of Exception

proc getRequest(endpoint: string): string =
  let client = newhttpClient()
  let response = client.request("https://theaudiodb.com/api/v1/json/2/" & endpoint, httpMethod = HttpGet)
  return response.body


proc searchArtist*(s: string): Artist =
  ##
  ## * `s` artist name
  ##
  ## Return Artist details from artist name
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"search.php?s={encodeUrl(s)}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["artists"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let data = to(json["artists"][0], Artist)
    return data
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc discography*(s: string): seq[Discography] =
  ##
  ## * `s` artist name
  ##
  ## Return Discography for an Artist with Album names and year onlye
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"discography.php?s={encodeUrl(s)}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["album"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    var array: seq[Discography] = @[]
    for i in json["album"]:
      array.add(to(i, Discography))
    return array
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchArtistById*(i: int): Artist =
  ##
  ## * `i` artist id
  ##
  ## Return individual Artist details using known Artist ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"artist.php?i={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["artists"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let data = to(json["artists"][0], Artist)
    return data
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchAlbumById*(i: int): Album =
  ##
  ## * `i` album id
  ##
  ## Return individual Album info using known Album ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"album.php?m={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["album"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let data = to(json["album"][0], Album)
    return data
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchAlbumsByArtistId*(i: int): seq[Album] =
  ##
  ## * `i` artist id
  ##
  ## Return All Albums for an Artist using known Artist ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"album.php?i={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["album"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    var array: seq[Album] = @[]
    for i in json["album"]:
      array.add(to(i, Album))
    return array
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchTracksByAlbumId*(i: int): seq[Track] =
  ##
  ## * `i` album id
  ##
  ## Return All Tracks for Album from known Album ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"track.php?m={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["track"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    var array: seq[Track] = @[]
    for i in json["track"]:
      array.add(to(i, Track))
    return array
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchTrackById*(i: int): Track =
  ##
  ## * `i` track id
  ##
  ## Return individual track info using a known Track ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"track.php?h={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["track"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let data = to(json["track"][0], Track)
    return data
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

proc searchMusicVideosByArtistId*(i: int): seq[MusicVideo] =
  ##
  ## * `i` artist id
  ##
  ## Return all the Music videos for a known Artist ID
  ## Raises AudioDBException
  try:
    let response = getRequest(fmt"mvid.php?i={i}")
    if response.len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    let json = parseJson(response)
    if json["mvids"].len == 0:
      raise AudioDBException.newException("Something went wrong: Empty response")
    var array: seq[MusicVideo] = @[]
    for i in json["mvids"]:
      array.add(to(i, MusicVideo))
    return array
  except:
    raise AudioDBException.newException(getCurrentExceptionMsg())

