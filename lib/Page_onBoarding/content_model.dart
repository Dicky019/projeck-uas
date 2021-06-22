class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Sistem Informasi',
      image: "assets/image/Onboarding3'1.png",
      discription:
          "Aplikasi ini untuk memudahkan mendapatkan "
          "informasi dari sesama member"),
  UnbordingContent(
      title: "Mencari seseorang",
      image: 'assets/image/Onboarding2.png',
      discription: "cari seseorang yang mungkin"
          "anda kenal berdasarkan konsentrasinya"),
  UnbordingContent(
      title: 'Menambahkan',
      image: "assets/image/Onboarding1.png",
      discription: "Menambah seseorang dan bisa juga mengupdatenya"),
];
