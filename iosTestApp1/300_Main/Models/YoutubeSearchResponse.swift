/*
 {
     etag = caOfEQPeWgEjw5Kc0O3Bdd48J0A;
     items =     (
                 {
             etag = "FLigV_B1qTLxi6FWvlvo4h_XD14";
             id =             {
                 kind = "youtube#video";
                 videoId = IsXB5eRMRno;
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "IDo_8EP7Iw7IZR9PLUyJL96pnPQ";
             id =             {
                 kind = "youtube#video";
                 videoId = uYb5gytMH4Y;
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "IOavuWymqlFj5cd7D3mK06r_ZM0";
             id =             {
                 kind = "youtube#video";
                 videoId = qN4ooNx77u0;
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "P6sBAwmuvGyub3_o6iIFWpx2EeA";
             id =             {
                 channelId = "UC0v-iWsXgVuckitOb1MM9cQ";
                 kind = "youtube#channel";
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "0-Mr3Sg2DRCB5AmgSXh_QcxhNoU";
             id =             {
                 kind = "youtube#video";
                 videoId = lpuUHM58ol4;
             };
             kind = "youtube#searchResult";
         }
     );
     kind = "youtube#searchListResponse";
     nextPageToken = CAUQAA;
     pageInfo =     {
         resultsPerPage = 5;
         totalResults = 730850;
     };
     regionCode = KR;
 }
 */

struct YoutubeSearchResults: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
