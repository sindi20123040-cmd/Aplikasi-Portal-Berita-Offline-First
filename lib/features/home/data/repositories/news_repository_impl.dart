import '../models/news_model.dart';

class NewsRepositoryImpl {
  NewsRepositoryImpl(dynamic dio, dynamic isar);

  Future<List<NewsModel>> fetchNews() async {
    // Menyediakan data tiruan yang dijamin langsung muncul tanpa internet
    final mockData = [
      NewsModel(
        title: 'Bursa Saham Menguat Tajam Hari Ini',
        description:
            'Indeks Harga Saham Gabungan mencatatkan kenaikan tertinggi sepanjang bulan ini didorong sektor teknologi.',
        urlToImage:
            'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?q=80&w=500',
      ),
      NewsModel(
        title: 'Teknologi AI Mengubah Industri Kesehatan',
        description:
            'Rumah sakit mulai menerapkan sistem kecerdasan buatan untuk mendeteksi penyakit secara lebih dini dan akurat.',
        urlToImage:
            'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=500',
      ),
      NewsModel(
        title: 'Anak Bangsa Menciptakan Mobil Listrik Ramah Lingkungan',
        description:
            'Kendaraan masa depan ini mampu menempuh jarak ratusan kilometer hanya dengan satu kali pengisian daya penuh.',
        urlToImage:
            'https://images.unsplash.com/photo-1563720223185-11003d516935?q=80&w=500',
      ),
    ];

    // ATURAN NIM GENAP: Wajib melakukan sorting data secara A-Z berdasarkan Judul
    mockData.sort((a, b) => a.title.compareTo(b.title));

    // Beri jeda loading singkat 1 detik agar animasi muter-muter (loading) bawaan Flutter tetap terlihat profesional
    await Future.delayed(const Duration(seconds: 1));

    return mockData;
  }
}
