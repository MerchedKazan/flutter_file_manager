import 'dart:io';

import 'package:file_manager_application/features/file_manager/data/file_manager_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'src/file_manager_repo_test.dart';


class MockDirectory extends Mock implements Directory {}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDirectory mockDirectory;
  late MockFileManager fileManagerProv;
  setUp(() {
    fileManagerProv=MockFileManager();
     mockDirectory = MockDirectory();
  });

        FileManagerRepo getFileManagerRepo(){
      final container=ProviderContainer(
        overrides: [
          fileManagerRepoProv.overrideWithValue(fileManagerProv)
        ]
      );
      addTearDown(() => container.dispose());
      return container.read(fileManagerRepoProv);
    }

test('createDirectory', () async {
  const mockPath = '/storage/emulated/0'; 
  const folderName = 'New Folder';
   final fileManagerTest=getFileManagerRepo();
   when(()=>fileManagerTest.createDirectory(mockPath, folderName)).thenAnswer((_) => Future.value());
   when(()=>fileManagerTest.directoryExist(mockPath, folderName)).thenAnswer((_) => true);
  // Act (call the function)
  await fileManagerTest.createDirectory(mockPath, folderName);
  fileManagerTest.directoryExist(mockPath, folderName);

  verify(()=> fileManagerTest.createDirectory(mockPath,folderName)).called(1); 
  verify(()=> fileManagerTest.directoryExist(mockPath,folderName)).called(1); 
  expect(fileManagerTest.directoryExist(mockPath, folderName), true);

});
test('deleteDirectory', () async {
  const mockPath = '/storage/emulated/0';
  const folderName = 'New Folder';
   final fileManagerTest=getFileManagerRepo();
  // Act (call the function)
  await fileManagerTest.createDirectory(mockPath, folderName);

  verify(()=> fileManagerTest.createDirectory(mockPath,folderName)).called(1);
  FileSystemEntity e=File(path.join(mockPath,folderName));
  await fileManagerTest.deleteDirectory(e);
  verify(()=> fileManagerTest.deleteDirectory(e)).called(1);

});
test('createDirectory', () async {
  const mockPath = '/storage/emulated/0'; 
  const folderName = 'New Folder';
   final fileManagerTest=getFileManagerRepo();
  // Act (call the function)
    FileSystemEntity e=File(path.join(mockPath,folderName));
  await fileManagerTest.renameDirectory(e,folderName);

  verify(()=> fileManagerTest.renameDirectory(e,folderName)).called(1); 

});
////////////////***************************************************** */
}
