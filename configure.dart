import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  print('Конфигуратор Flutter проекта');
  print('-----------------------------');
   final newAppName = await updateAppName();
   await updateMainDartTitle(newAppName);
  await updateBundleId();
   await updateInfoPlist();
  await updateCodemagicYaml();

  print('Конфигурация завершена.');
}

Future<void> updateBundleId() async {
  print('\nОбновление Bundle ID:');
  final newBundleId = promptUser('Введите новый Bundle ID:');

  await updateFile('android/app/src/main/AndroidManifest.xml',
      RegExp(r'package="[^"]*"'), 'package="$newBundleId"');
  await updateFile('android/app/build.gradle', RegExp(r'applicationId "[^"]*"'),
      'applicationId "$newBundleId"');
  await updateFile(
      'ios/Runner.xcodeproj/project.pbxproj',
      RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = [^;]+'),
      'PRODUCT_BUNDLE_IDENTIFIER = $newBundleId');
  await updateFile('codemagic.yaml', RegExp(r'(bundle_identifier:).*'),
      'bundle_identifier: $newBundleId');
  await updateBuildGradle(newBundleId);
  // Обновление MainActivity.kt
  final mainActivityFile = await findMainActivityFile();
  if (mainActivityFile != null) {
    final oldPackage = extractPackageFromFile(mainActivityFile);
    if (oldPackage != null) {
      await updateFile(mainActivityFile.path, RegExp('package $oldPackage'),
          'package $newBundleId');
      print('MainActivity.kt обновлен: package $newBundleId');
    } else {
      print('Не удалось извлечь текущий пакет из MainActivity.kt');
    }
  } else {
    print('MainActivity.kt не найден');
  }

  print('Bundle ID обновлен на: $newBundleId');
}

Future<void> updateBuildGradle(String newBundleId) async {
  print('\nОбновление build.gradle:');
  final buildGradleFile = File('android/app/build.gradle');
  if (!await buildGradleFile.exists()) {
    print('Файл build.gradle не найден.');
    return;
  }
  await updateFile('android/app/build.gradle',
      RegExp(r'applicationId = "[^"]*"'), 'applicationId = "$newBundleId"');
  await updateFile('android/app/build.gradle',
      RegExp(r'namespace = "[^"]*"'), 'namespace = "$newBundleId"');
  String content = await buildGradleFile.readAsString();
/* 
  // Обновление applicationId
  final applicationIdRegex = RegExp(r'applicationId "[^"]*"');
  content =
      content.replaceFirst(applicationIdRegex, 'applicationId "$newBundleId"');

  // Обновление namespace
  final namespaceRegex = RegExp(r'namespace "[^"]*"');
  content = content.replaceFirst(namespaceRegex, 'namespace "$newBundleId"');

  await buildGradleFile.writeAsString(content); */
  print(
      'build.gradle обновлен: applicationId и namespace изменены на $newBundleId');
}

Future<String> updateAppName() async {
  print('\nОбновление названия приложения:');
  final newAppName = promptUser('Введите новое название приложения:');

  await updateFile('android/app/src/main/AndroidManifest.xml',
      RegExp(r'android:label="[^"]*"'), 'android:label="$newAppName"');
  await updateFile(
      'ios/Runner/Info.plist',
      RegExp(r'<key>CFBundleName</key>\s*<string>[^<]*</string>'),
      '<key>CFBundleName</key>\n\t<string>$newAppName</string>');
  await updateFile(
      'ios/Runner/Info.plist',
      RegExp(r'<key>CFBundleDisplayName</key>\s*<string>[^<]*</string>'),
      '<key>CFBundleDisplayName</key>\n\t<string>$newAppName</string>');
  print('Название приложения обновлено на: $newAppName');
  return newAppName;
}

Future<void> updateMainDartTitle(String newAppName) async {
  print('\nОбновление названия в main.dart:');
  final mainDartFile = File('lib/main.dart');
  if (!await mainDartFile.exists()) {
    print('Файл main.dart не найден.');
    return;
  }

  String content = await mainDartFile.readAsString();
  final titleRegex = RegExp(r'title: [\"].*?[\"]');
  if (titleRegex.hasMatch(content)) {
    content = content.replaceFirst(titleRegex, "title: '$newAppName'");
    await mainDartFile.writeAsString(content);
    print('Название в main.dart обновлено на: $newAppName');
  } else {
    print('В main.dart не найдено поле title для обновления.');
  }
}

Future<void> updateInfoPlist() async {
  print('\nОбновление Info.plist:');
  final infoPlistFile = File('ios/Runner/Info.plist');
  if (!await infoPlistFile.exists()) {
    print('Файл Info.plist не найден.');
    return;
  }

  String content = await infoPlistFile.readAsString();

  // Автоматическое добавление ITSAppUsesNonExemptEncryption
  if (!content.contains('<key>ITSAppUsesNonExemptEncryption</key>')) {
    content = content.replaceFirst('</dict>', '''
  <key>ITSAppUsesNonExemptEncryption</key>
  <false/>
</dict>''');
    print('Добавлен параметр ITSAppUsesNonExemptEncryption: false');
  }

  // Запрос на добавление дополнительного ключа
  final addNewKey =
      promptUser('Хотите добавить новый ключ в Info.plist? (y/n): ')
              .toLowerCase() ==
          'y';
  if (addNewKey) {
    final key = promptUser('Введите ключ: ');
    final value = promptUser('Введите значение: ');
    content = content.replaceFirst('</dict>', '''
  <key>$key</key>
  <string>$value</string>
</dict>''');
    print('Добавлен новый ключ в Info.plist: $key = $value');
  }

  await infoPlistFile.writeAsString(content);
}

Future<void> updateCodemagicYaml() async {
  print('\nОбновление codemagic.yaml:');
  final newAppStoreConnect =
      promptUser('Введите новое значение для integrations.app_store_connect:');

  await updateFile('codemagic.yaml', RegExp(r'(app_store_connect:).*'),
      'app_store_connect: $newAppStoreConnect');

  print('codemagic.yaml успешно обновлен');
}

String promptUser(String prompt) {
  stdout.write('$prompt ');
  return stdin.readLineSync() ?? '';
}

Future<void> updateFile(String path, RegExp pattern, String replacement) async {
  final file = File(path);
  if (await file.exists()) {
    String content = await file.readAsString();
    content = content.replaceFirst(pattern, replacement);
    await file.writeAsString(content);
  } else {
    print('Предупреждение: Файл $path не найден.');
  }
}

Future<File?> findMainActivityFile() async {
  final androidDir = Directory('android/app/src/main/kotlin');
  if (!await androidDir.exists()) {
    print('Директория kotlin не найдена');
    return null;
  }

  return androidDir
      .list(recursive: true)
      .where((entity) =>
          entity is File && path.basename(entity.path) == 'MainActivity.kt')
      .cast<File>()
      .first;
}

String? extractPackageFromFile(File file) {
  final content = file.readAsStringSync();
  final match = RegExp(r'package\s+([\w.]+)').firstMatch(content);
  return match?.group(1);
}
