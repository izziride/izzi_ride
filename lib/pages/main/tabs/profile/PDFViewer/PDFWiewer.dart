import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';


const conditionPdf="http://ezride.pro/docs/condition-use.pdf";
const policyPdf="http://ezride.pro/docs/private-policy.pdf";


enum PDFTYPE{
  condition,
  policy
}

class PDFWiewer extends StatefulWidget {
  final PDFTYPE pdftype;
  const PDFWiewer({required this.pdftype, super.key});

  @override
  State<PDFWiewer> createState() => _PDFWiewerState();
}

class _PDFWiewerState extends State<PDFWiewer> {

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    File file=File("");
   
    final directory = await getApplicationDocumentsDirectory();
    if(widget.pdftype==PDFTYPE.condition){
       file = File('${directory.path}/sample.pdf');
       final response = await http.get(Uri.parse( conditionPdf));
        await file.writeAsBytes(response.bodyBytes);
    }
    if(widget.pdftype==PDFTYPE.policy){
      file = File('${directory.path}/policy.pdf');
       final response = await http.get(Uri.parse( policyPdf));
        await file.writeAsBytes(response.bodyBytes);
    }
    
   
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }
  @override
  void initState() {
   loadPdf();
    super.initState();
  }
  @override
  void dispose() {
    File(pdfFlePath!).delete();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: pdfFlePath==null?Center(child: CircularProgressIndicator())
      :Column(
        children: [
          BarNavigation(back: true, title: widget.pdftype==PDFTYPE.policy?"Privacy Policy":"Terms of Use"),
          Expanded(
            child: PdfView(
              
              path: pdfFlePath!,
              
            
              ),
          ),
        ],
      )
    );
  }
}




