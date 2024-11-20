import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:yaml/yaml.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdfDoc;

void main() {
  runApp(const MyApp());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String? myYamlContent;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  takeYamlFromTextField(context);
                },
                child: const Text("Yaml to Pdf")),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  myYamlContent = await readPdf();
                  if(context.mounted){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 400,
                          child: AlertDialog(
                            title: const Text("Pdf Content"),
                            content: SingleChildScrollView(
                              child: SelectableText(myYamlContent!),
                            ),
                          ),
                        );
                      });
                  }
                },
                child: const Text("Pdf to Yaml")),
          ],
        ),
      ),
    );
  }

  Future<pw.Document> createPdf(
      {required String yamlData, required BuildContext context}) async {final fontData =
        await rootBundle.load("assets/OpenSans-VariableFont_wdth,wght.ttf");
    final customFont = pw.Font.ttf(fontData);
        int linesPerPage = 40;
        final textLines = yamlData.split('\n');
        
final pdf = pw.Document();
        for(int i=0;i<textLines.length; i+=linesPerPage){
          final page = textLines.sublist(i, i+linesPerPage<textLines.length?i+linesPerPage:textLines.length);
  pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: page.map((line)=>pw.Text(
            line,
            style: pw.TextStyle(font: customFont),
          )).toList());
        }));
        }
    
    
    
  
    return pdf;
  }

  Future<String> readPdf() async {
    const XTypeGroup typeGroup =
        XTypeGroup(label: "documents", extensions: <String>['pdf']);
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    pdfDoc.PdfDocument document =
        pdfDoc.PdfDocument(inputBytes: await file!.readAsBytes());
    String myYamlContent = pdfDoc.PdfTextExtractor(document).extractText();
    print(myYamlContent);
    return myYamlContent;
  }

  void takeYamlFromTextField(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter Yaml text below"),
            content: TextField(
              // style: const TextStyle(fontFamily: "opensans"),
              controller: controller,
              maxLines: 8,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final pdf = await createPdf(
                        yamlData: controller.text.toString(), context: context);
                    final Directory tempDir = await getTemporaryDirectory();
                    File file =
                        File(path.join(tempDir.path, "academy_file.pdf"));
                    file.writeAsBytesSync(await pdf.save());
                    Share.shareXFiles([
                      XFile(path.join(tempDir.path, "academy_file.pdf"))
                    ]).then((v) {
                      file.delete();
                    });
                  },
                  child: const Text("Create and Share"))
            ],
          );
        });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
