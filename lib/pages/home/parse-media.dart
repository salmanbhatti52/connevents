import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/models/business-create-model.dart';


List<ImageData>  parseMedia(EventDetail e){
  return [
    if(e.firstImage.isNotEmpty)  ImageData(
        attachment: e.firstImage,
        type: "image",
        media: ""
    ),
    if(e.secondImage.isNotEmpty)   ImageData(
        attachment: e.secondImage,
        type: "image",
        media: ""
    ),
    if(e.thirdImage.isNotEmpty)    ImageData(
        attachment: e.thirdImage,
        type: "image",
        media: ""
    ),
    if(e.first_video_thumbnail.isNotEmpty)     ImageData(
        attachment: e.first_video_thumbnail,
        type: "video",
        media: e.firstVideo
    ),
    if(e.second_video_thumbnail.isNotEmpty)     ImageData(
        attachment: e.second_video_thumbnail,
        type: "video",

        media: e.secondVideo
    ),
    if(e.third_video_thumbnail.isNotEmpty)    ImageData(
        attachment: e.third_video_thumbnail,
        type: "video",
        media: e.thirdVideo
    ),
  ];
}




List<ImageData>  businessParseMedia(Business e){
  return [
    if(e.firstImage.isNotEmpty)  ImageData(
        attachment: e.firstImage,
        type: "image",
        media: ""
    ),
    if(e.secondImage.isNotEmpty)   ImageData(
        attachment: e.secondImage,
        type: "image",
        media: ""
    ),
    if(e.thirdImage.isNotEmpty)    ImageData(
        attachment: e.thirdImage,
        type: "image",
        media: ""
    ),
    if(e.fourthImage.isNotEmpty)    ImageData(
        attachment: e.fourthImage,
        type: "image",
        media: ""
    ),
    if(e.fifthImage.isNotEmpty)    ImageData(
        attachment: e.fifthImage,
        type: "image",
        media: ""
    ),
    if(e.sixthImage.isNotEmpty)    ImageData(
        attachment: e.sixthImage,
        type: "image",
        media: ""
    ),
    if(e.first_video_thumbnail.isNotEmpty)     ImageData(
        attachment: e.first_video_thumbnail,
        type: "video",
        media: e.firstVideo
    ),
    if(e.second_video_thumbnail.isNotEmpty)     ImageData(
        attachment: e.second_video_thumbnail,
        type: "video",

        media: e.secondVideo
    ),
    if(e.third_video_thumbnail.isNotEmpty)    ImageData(
        attachment: e.third_video_thumbnail,
        type: "video",
        media: e.thirdVideo
    ),
  ];
}