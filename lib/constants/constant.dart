import 'package:new_invoice_bangla/utils/bangla_unicode_util.dart';

const String brand = 'assets/images/logo.png';
const String banglaFont = 'assets/fonts/kalpurush.ttf';

final String company = 'ক্যাফে আড্ডা'.toRepair();
final String mobile = '01908-000333'.toRepair();
final String address = 'শেরে বাংলা রোড, ঝিনাইদহ ৭৩০০'.toRepair();
final String addresssTitle = 'ঠিকানা ঃ '.toRepair();
final String telTitle = 'মোবাইল ঃ'.toRepair();
final String totalDueTitle = 'মোট বকেয়া'.toRepair();
final String vat = 'ভ্যাট '.toRepair();
final String totalTitle = 'সর্বমোট'.toRepair();
final String name = 'ক্যাফে আড্ডা ফাস্ট ফুড এন্ড রেস্টুরেন্ট'.toRepair();
final String cashmemo = 'ক্যাশ মেমো'.toRepair();
final List tableHeaders = [
  'আইটেম',
  'পরিমান',
  'দর',
  'ডিস্কাউন্ট',
  'মোট',
].map((e) => e.toRepair()).toList();
