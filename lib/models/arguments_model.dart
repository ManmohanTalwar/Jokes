class ScreenArguments {
  final String title;
  final int? propertyID;
  final bool isPropertyTab;
  final bool showBookingButton;
  final bool isAssetSlider;
  final bool isStatic;
  final int? specialRequestID;
  final String? specialRequesttitle;
  final int? complaintID;
  final String? complainttitle;
  final int? bookingID;
  final String? propertyImage;

  ScreenArguments(
      {this.propertyID,
      this.isPropertyTab = false,
      this.showBookingButton = true,
      this.isAssetSlider = false,
      this.isStatic = false,
      this.title = 'null',
      this.specialRequestID,
      this.specialRequesttitle,
      this.complaintID,
      this.complainttitle,
      this.bookingID,
      this.propertyImage});
}
