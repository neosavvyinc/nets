/**
 * Appcelerator Titanium Mobile
 * This is generated code. Do not modify. Your changes *will* be lost.
 * Generated code is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * All Rights Reserved.
 */
#import <Foundation/Foundation.h>
#import "ApplicationRouting.h"

extern NSData * decode64 (NSData * thedata); 
extern NSData * dataWithHexString (NSString * hexString);
extern NSData * decodeDataWithKey (NSData * thedata, NSString * key);

@implementation ApplicationRouting

+ (NSData*) resolveAppAsset:(NSString*)path;
{
     static NSMutableDictionary *map;
     if (map==nil)
     {
         map = [[NSMutableDictionary alloc] init];
         [map setObject:dataWithHexString(@"546974616e69756d2e55492e7365744261636b67726f756e64436f6c6f7228272330303027293b7661722068747470436c69656e743d546974616e69756d2e4e6574776f726b2e63726561746548545450436c69656e7428293b766172206d6f62696c65536572766963654261736555726c3d27687474703a2f2f6c6f63616c686f73743a383038302f6e6574732f657870656e73652f73657276696365732f6d6f62696c65273b7661722073746f72616765536572766963654261736555726c3d27687474703a2f2f6c6f63616c686f73743a383038302f6e6574732f73746f72616765273b766172207365637572697479577261707065723d6e756c6c3b766172206170703d546974616e69756d2e55492e63726561746557696e646f77287b7469746c653a274e455453272c6261636b67726f756e64436f6c6f723a2723303030277d293b7661722076696577436f6e7461696e65723d546974616e69756d2e55492e63726561746556696577287b746f703a36302c77696474683a3332302c6865696768743a3432307d293b546974616e69756d2e696e636c7564652827736572766963652e6a7327293b546974616e69756d2e696e636c756465282764617368626f6172642e6a7327293b546974616e69756d2e696e636c75646528276c6f67696e2e6a7327293b546974616e69756d2e696e636c7564652827636f6e6669726d5f726563656970745f75706c6f61642e6a7327293b546974616e69756d2e696e636c75646528276c6f67696e5f68616e646c6572732e6a7327293b546974616e69756d2e696e636c756465282764617368626f6172645f68616e646c6572732e6a7327293b546974616e69756d2e696e636c756465282770726f67726573732e6a7327293b76696577436f6e7461696e65722e616464286c6f67696e293b76696577436f6e7461696e65722e6164642864617368626f617264293b76696577436f6e7461696e65722e61646428636f6e6669726d5265636569707455706c6f6164293b66756e6374696f6e2073686f774c6f67696e28297b76696577436f6e7461696e65722e616e696d617465287b766965773a6c6f67696e2c7472616e736974696f6e3a54692e55492e6950686f6e652e416e696d6174696f6e5374796c652e464c49505f46524f4d5f4c4546547d293b6c6f67696e2e76697369626c653d747275653b64617368626f6172642e76697369626c653d66616c73653b636f6e6669726d5265636569707455706c6f61642e76697369626c653d66616c73653b7d0a66756e6374696f6e2073686f7744617368626f61726428297b76696577436f6e7461696e65722e616e696d617465287b766965773a64617368626f6172642c7472616e736974696f6e3a54692e55492e6950686f6e652e416e696d6174696f6e5374796c652e464c49505f46524f4d5f4c4546547d293b6c6f67696e2e76697369626c653d66616c73653b64617368626f6172642e76697369626c653d747275653b636f6e6669726d5265636569707455706c6f61642e76697369626c653d66616c73653b54692e4170702e666972654576656e742822757365724c6f67676564496e222c7b7365637572697479577261707065723a7365637572697479577261707065727d293b54692e4170702e666972654576656e7428226c6f616444617368626f61726422293b7d0a66756e6374696f6e2073686f77436f6e6669726d5265636569707455706c6f616428297b76696577436f6e7461696e65722e616e696d617465287b766965773a636f6e6669726d5265636569707455706c6f61642c7472616e736974696f6e3a54692e55492e6950686f6e652e416e696d6174696f6e5374796c652e464c49505f46524f4d5f4c4546547d293b6c6f67696e2e76697369626c653d66616c73653b64617368626f6172642e76697369626c653d66616c73653b636f6e6669726d5265636569707455706c6f61642e76697369626c653d747275653b7d0a6170702e6164642876696577436f6e7461696e6572293b6170702e6f70656e287b7472616e736974696f6e3a546974616e69756d2e55492e6950686f6e652e416e696d6174696f6e5374796c652e464c49505f46524f4d5f4c4546547d293b73686f774c6f67696e28293b69662821546974616e69756d2e4e6574776f726b2e6f6e6c696e65297b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274e6574776f726b20436f6e6e656374696f6e205265717569726564272c6d6573736167653a274e45545320726571756972657320616e20696e7465726e657420636f6e6e656374696f6e202e2020436865636b20796f7572206e6574776f726b20636f6e6e656374696f6e20616e642074727920616761696e2e277d293b612e73686f7728293b7d") forKey:@"app_js"];
         [map setObject:dataWithHexString(@"7661722063757272656e7452656365697074496d6167653d6e756c6c3b76617220726563656970744e616d6556616c3b76617220636f6e6669726d5265636569707455706c6f61643d546974616e69756d2e55492e63726561746556696577287b746f703a302c77696474683a3332302c6865696768743a3432302c6f7061636974793a317d293b7661722075706c6f616450726f67726573733d546974616e69756d2e55492e63726561746550726f6772657373426172287b77696474683a3230302c6865696768743a35302c6d696e3a302c6d61783a312c76616c75653a302c7374796c653a546974616e69756d2e55492e6950686f6e652e50726f67726573734261725374796c652e504c41494e2c746f703a31302c6d6573736167653a2757616974696e672e2e2e272c666f6e743a7b666f6e7453697a653a31322c666f6e745765696768743a27626f6c64277d2c636f6c6f723a2723383838277d293b636f6e6669726d5265636569707455706c6f61642e6164642875706c6f616450726f6772657373293b75706c6f616450726f67726573732e73686f7728293b766172206e616d654669656c643d546974616e69756d2e55492e637265617465546578744669656c64287b68696e74546578743a27456e7465722052656365697074204e616d65272c6865696768743a33352c746f703a37302c6c6566743a33302c77696474683a3235302c6b6579626f617264547970653a546974616e69756d2e55492e4b4559424f4152445f44454641554c542c72657475726e4b6579547970653a546974616e69756d2e55492e52455455524e4b45595f44454641554c542c626f726465725374796c653a546974616e69756d2e55492e494e5055545f424f524445525354594c455f524f554e4445442c6175746f636f72726563743a747275657d293b636f6e6669726d5265636569707455706c6f61642e616464286e616d654669656c64293b7661722075706c6f6164427574746f6e3d546974616e69756d2e55492e637265617465427574746f6e287b7469746c653a2755706c6f6164272c746f703a3134302c6c6566743a33302c6865696768743a33302c77696474683a3235307d293b636f6e6669726d5265636569707455706c6f61642e6164642875706c6f6164427574746f6e293b7661722063616e63656c427574746f6e3d546974616e69756d2e55492e637265617465427574746f6e287b7469746c653a2743616e63656c272c746f703a3139302c6c6566743a33302c6865696768743a33302c77696474683a3235307d293b636f6e6669726d5265636569707455706c6f61642e6164642863616e63656c427574746f6e293b63616e63656c427574746f6e2e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e2865297b73686f7744617368626f61726428293b7d293b6e616d654669656c642e6164644576656e744c697374656e6572282772657475726e272c66756e6374696f6e28297b6e616d654669656c642e626c757228293b7d293b6e616d654669656c642e6164644576656e744c697374656e657228276368616e6765272c66756e6374696f6e2865297b726563656970744e616d6556616c3d652e76616c75653b7d293b66756e6374696f6e206f6e5265636569707455706c6f61644661696c7572652865297b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f707321272c6d6573736167653a22416e206572726f72206f63637572726564207768696c652075706c6f6164696e6720746865207265636569707420746f206f757220736572766572732e2020506c656173652074727920616761696e206c617465722e227d293b612e73686f7728293b612e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e28297b73686f7744617368626f61726428293b7d293b7d0a66756e6374696f6e206f6e5265636569707455706c6f616465642873746f726167655365727669636546696c65526566297b54692e4150492e696e666f2873746f726167655365727669636546696c65526566293b69662873746f726167655365727669636546696c655265663d3d6e756c6c297b6f6e5265636569707455706c6f61644661696c757265286e756c6c293b72657475726e3b7d0a76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a2755706c6f6164656421272c6d6573736167653a22596f7572207265636569707420686173206265656e20616464656420746f20796f7572206163636f756e742e2020596f752063616e206c6f6720696e20746f20796f7572206163636f756e7420616e642061646420746865207265636569707420746f20616e20657870656e7365207265706f7274206c617465722e227d293b612e73686f7728293b612e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e28297b73686f7744617368626f61726428293b7d293b7d0a66756e6374696f6e206f6e5265636569707450726f67726573732870726f6772657373297b75706c6f616450726f67726573732e76616c75653d70726f67726573733b7d0a75706c6f6164427574746f6e2e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e2865297b696628726563656970744e616d6556616c3d3d6e756c6c7c7c726563656970744e616d6556616c2e6c656e6774683d3d30297b616c6572742827596f75206d75737420656e74657220612072656365697074206e616d652e27293b72657475726e3b7d0a75706c6f616450726f67726573732e6d6573736167653d2755706c6f6164696e6720526563656970742e2e2e273b75706c6f6164427574746f6e2e76697369626c653d66616c73653b63616e63656c427574746f6e2e76697369626c653d66616c73653b7365727669636555706c6f61645265636569707428726563656970744e616d6556616c2c63757272656e7452656365697074496d6167652c6f6e5265636569707455706c6f616465642c6f6e5265636569707455706c6f61644661696c7572652c6f6e5265636569707450726f6772657373293b7d293b54692e4170702e6164644576656e744c697374656e65722822636f6e6669726d5265636569707455706c6f6164222c66756e6374696f6e2865297b75706c6f616450726f67726573732e76616c75653d303b6e616d654669656c642e76616c75653d27273b726563656970744e616d6556616c3d6e756c6c3b63616e63656c427574746f6e2e76697369626c653d747275653b75706c6f6164427574746f6e2e76697369626c653d747275653b75706c6f616450726f67726573732e6d6573736167653d2757616974696e672e2e2e273b73686f77436f6e6669726d5265636569707455706c6f616428293b7d293b") forKey:@"confirm_receipt_upload_js"];
         [map setObject:dataWithHexString(@"7661722064617368626f617264446174613d6e756c6c3b7661722064617368626f6172643d546974616e69756d2e55492e63726561746556696577287b746f703a302c77696474683a3332302c6865696768743a3432302c6f7061636974793a317d293b766172206772656574696e674c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2757656c636f6d65272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a302c6c6566743a33307d293b64617368626f6172642e616464286772656574696e674c6162656c293b76617220617070726f76696e67446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a33302c6c6566743a31307d293b64617368626f6172642e61646428617070726f76696e67446174614c6162656c293b76617220617070726f76696e674c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a27417070726f76696e67272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a33302c6c6566743a35307d293b64617368626f6172642e61646428617070726f76696e674c6162656c293b76617220617070726f766564446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a35352c6c6566743a31307d293b64617368626f6172642e61646428617070726f766564446174614c6162656c293b76617220617070726f7665644c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a27417070726f766564272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a35352c6c6566743a35307d293b64617368626f6172642e61646428617070726f7665644c6162656c293b766172206465636c696e6564446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a38302c6c6566743a31307d293b64617368626f6172642e616464286465636c696e6564446174614c6162656c293b766172206465636c696e65644c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a274465636c696e6564272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a38302c6c6566743a35307d293b64617368626f6172642e616464286465636c696e65644c6162656c293b766172206f70656e446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3130352c6c6566743a31307d293b64617368626f6172642e616464286f70656e446174614c6162656c293b766172206f70656e4c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a27417070726f766564272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3130352c6c6566743a35307d293b64617368626f6172642e616464286f70656e4c6162656c293b766172206177616974696e67446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3133302c6c6566743a31307d293b64617368626f6172642e616464286177616974696e67446174614c6162656c293b766172206177616974696e674c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a274177616974696e67205265636f6e63696c696174696f6e272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3133302c6c6566743a35307d293b64617368626f6172642e616464286177616974696e674c6162656c293b766172207265636f6e63696c6564446174614c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a2730272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3135352c6c6566743a31307d293b64617368626f6172642e616464287265636f6e63696c6564446174614c6162656c293b766172207265636f6e63696c65644c6162656c3d546974616e69756d2e55492e6372656174654c6162656c287b746578743a275265636f6e63696c6564272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3135352c6c6566743a35307d293b64617368626f6172642e616464287265636f6e63696c65644c6162656c293b7661722061646452656365697074427574746f6e3d546974616e69756d2e55492e637265617465427574746f6e287b7469746c653a274164642052656365697074272c746f703a3139302c6c6566743a33302c6865696768743a33302c77696474683a3235307d293b61646452656365697074427574746f6e2e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e2865297b54692e4170702e666972654576656e742822646973706c617943616d65726122293b7d293b64617368626f6172642e6164642861646452656365697074427574746f6e293b66756e6374696f6e2075706461746544617368626f617264446174612864617461297b64617368626f617264446174613d646174613b617070726f76696e67446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f7274734177616974696e67417070726f76616c3b617070726f766564446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f727473417070726f7665643b6465636c696e6564446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f7274734465636c696e65643b6f70656e446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f7274734f70656e65643b6177616974696e67446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f7274734177616974696e675265636f6e63696c696174696f6e3b7265636f6e63696c6564446174614c6162656c2e746578743d64617368626f617264446174612e6e756d626572457870656e73655265706f7274735265636f6e63696c65643b7d0a54692e4170702e6164644576656e744c697374656e65722822757365724c6f67676564496e222c66756e6374696f6e2865297b6772656574696e674c6162656c2e746578743d2757656c636f6d6520272b652e7365637572697479577261707065722e6e616d653b7d293b") forKey:@"dashboard_js"];
         [map setObject:dataWithHexString(@"66756e6374696f6e20646973706c617944617368626f6172644c6f61644572726f7228297b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f707321272c6d6573736167653a22576520776572656e27742061626c6520746f206c6f616420796f75722064617368626f617264206461746120617420746869732074696d652e2020506c656173652074727920616761696e206c617465722e227d293b612e73686f7728293b7d0a66756e6374696f6e206f6e44617368626f6172644c6f61644661696c7572652865297b54692e4170702e666972654576656e742827686964654163746976697479496e64696361746f7227293b7d0a66756e6374696f6e206f6e44617368626f6172644c6f6164436f6d706c6574652864617461297b54692e4170702e666972654576656e742827686964654163746976697479496e64696361746f7227293b696628646174613d3d6e756c6c297b646973706c617944617368626f6172644c6f61644572726f7228293b72657475726e3b7d0a75706461746544617368626f6172642864617461293b7d0a66756e6374696f6e206c6f616444617368626f6172644461746128297b54692e4170702e666972654576656e742827646973706c61794163746976697479496e64696361746f72272c7b6d6573736167653a274c6f6164696e672064617368626f6172642e2e2e277d293b7365727669636547657444617368626f61726444617461286f6e44617368626f6172644c6f6164436f6d706c6574652c6f6e44617368626f6172644c6f61644661696c757265293b7d0a66756e6374696f6e2068616e646c6552656365697074496d6167654576656e742865297b63757272656e7452656365697074496d6167653d652e6d656469613b54692e4170702e666972654576656e742822636f6e6669726d5265636569707455706c6f616422293b7d0a66756e6374696f6e2073686f7743616d65726128297b546974616e69756d2e4d656469612e73686f7743616d657261287b737563636573733a66756e6374696f6e286576656e74297b68616e646c6552656365697074496d6167654576656e74286576656e74293b7d2c63616e63656c3a66756e6374696f6e28297b7d2c6572726f723a66756e6374696f6e286572726f72297b6966286572726f722e636f64653d3d546974616e69756d2e4d656469612e4e4f5f43414d455241297b546974616e69756d2e4d656469612e6f70656e50686f746f47616c6c657279287b737563636573733a66756e6374696f6e286576656e74297b68616e646c6552656365697074496d6167654576656e74286576656e74293b7d2c63616e63656c3a66756e6374696f6e28297b7d2c6572726f723a66756e6374696f6e286572726f72297b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f707321272c6d6573736167653a2757652068616420612070726f626c656d2072656164696e672066726f6d20796f75722070686f746f2067616c6c657279202d20706c656173652074727920616761696e277d293b612e73686f7728293b7d2c616c6c6f77496d61676545646974696e673a747275657d293b7d0a656c73657b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f70732e2e2e277d293b612e7365744d6573736167652827556e6578706563746564206572726f723a20272b6572726f722e636f6465293b612e73686f7728293b7d7d2c616c6c6f77496d61676545646974696e673a747275657d293b7d0a66756e6374696f6e2075706c6f6164526563656970742865297b7d0a54692e4170702e6164644576656e744c697374656e657228226c6f616444617368626f617264222c6c6f616444617368626f61726444617461293b54692e4170702e6164644576656e744c697374656e65722822646973706c617943616d657261222c73686f7743616d657261293b54692e4170702e6164644576656e744c697374656e6572282275706c6f616452656365697074222c75706c6f616452656365697074293b") forKey:@"dashboard_handlers_js"];
         [map setObject:dataWithHexString(@"76617220757365726e616d6556616c3d546974616e69756d2e4170702e50726f706572746965732e676574537472696e672822756e22293b7661722070617373776f726456616c3d546974616e69756d2e4170702e50726f706572746965732e676574537472696e672822707722293b7661722072656d656d6265724d6556616c3d28757365726e616d6556616c213d6e756c6c2626757365726e616d6556616c213d27272926262870617373776f726456616c213d6e756c6c262670617373776f726456616c213d2727293b766172206c6f67696e3d546974616e69756d2e55492e63726561746556696577287b746f703a36302c77696474683a3332302c6865696768743a3432302c6f7061636974793a317d293b76617220757365726e616d654669656c643d546974616e69756d2e55492e637265617465546578744669656c64287b68696e74546578743a27456e74657220557365726e616d65272c6865696768743a33352c746f703a31302c6c6566743a33302c77696474683a3235302c6b6579626f617264547970653a546974616e69756d2e55492e4b4559424f4152445f44454641554c542c72657475726e4b6579547970653a546974616e69756d2e55492e52455455524e4b45595f44454641554c542c626f726465725374796c653a546974616e69756d2e55492e494e5055545f424f524445525354594c455f524f554e4445442c6175746f636f72726563743a66616c73657d293b757365726e616d654669656c642e6164644576656e744c697374656e6572282772657475726e272c66756e6374696f6e28297b757365726e616d654669656c642e626c757228293b7d293b757365726e616d654669656c642e6164644576656e744c697374656e657228276368616e6765272c66756e6374696f6e2865297b757365726e616d6556616c3d652e76616c75653b7d293b757365726e616d654669656c642e76616c75653d757365726e616d6556616c3b6c6f67696e2e61646428757365726e616d654669656c64293b7661722070617373776f72644669656c643d546974616e69756d2e55492e637265617465546578744669656c64287b68696e74546578743a27456e7465722050617373776f7264272c6865696768743a33352c746f703a36352c6c6566743a33302c77696474683a3235302c6b6579626f617264547970653a546974616e69756d2e55492e4b4559424f4152445f44454641554c542c72657475726e4b6579547970653a546974616e69756d2e55492e52455455524e4b45595f44454641554c542c626f726465725374796c653a546974616e69756d2e55492e494e5055545f424f524445525354594c455f524f554e4445442c6175746f636f72726563743a66616c73652c70617373776f72644d61736b3a747275657d293b70617373776f72644669656c642e6164644576656e744c697374656e6572282772657475726e272c66756e6374696f6e28297b70617373776f72644669656c642e626c757228293b7d293b70617373776f72644669656c642e6164644576656e744c697374656e657228276368616e6765272c66756e6374696f6e2865297b70617373776f726456616c3d652e76616c75653b7d293b70617373776f72644669656c642e76616c75653d70617373776f726456616c3b6c6f67696e2e6164642870617373776f72644669656c64293b7661722072656d656d6265724d654669656c643d546974616e69756d2e55492e637265617465537769746368287b76616c75653a66616c73652c746f703a3132302c6c6566743a33302c6865696768743a276175746f277d293b72656d656d6265724d654669656c642e6164644576656e744c697374656e657228276368616e6765272c66756e6374696f6e2865297b72656d656d6265724d6556616c3d652e76616c75653b7d293b72656d656d6265724d654669656c642e76616c75653d72656d656d6265724d6556616c3b6c6f67696e2e6164642872656d656d6265724d654669656c64293b7661722072656d656d6265724d654c6162656c3d54692e55492e6372656174654c6162656c287b746578743a2752656d656d626572204c6f67696e272c74657874416c69676e3a274c656674272c6865696768743a276175746f272c77696474683a276175746f272c636f6c6f723a2723666666272c746f703a3132302c6c6566743a3133307d293b6c6f67696e2e6164642872656d656d6265724d654c6162656c293b766172206c6f67696e427574746f6e3d546974616e69756d2e55492e637265617465427574746f6e287b7469746c653a274c6f67696e272c746f703a3137302c6c6566743a33302c6865696768743a33302c77696474683a3235307d293b6c6f67696e2e616464286c6f67696e427574746f6e293b6c6f67696e427574746f6e2e6164644576656e744c697374656e65722822636c69636b222c66756e6374696f6e2865297b54692e4170702e666972654576656e7428226c6f67696e526571756573746564222c7b757365726e616d653a757365726e616d6556616c2c70617373776f72643a70617373776f726456616c2c72656d656d6265724d653a72656d656d6265724d6556616c7d293b7d293b") forKey:@"login_js"];
         [map setObject:dataWithHexString(@"66756e6374696f6e206f6e4c6f67696e4661696c7572652865297b54692e4170702e666972654576656e742827686964654163746976697479496e64696361746f7227293b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f70732e2e2e272c6d6573736167653a22576520776572656e27742061626c6520746f206c6f6720796f7520696e20617420746869732074696d652e2020506c656173652074727920616761696e2e227d293b612e73686f7728293b7d0a66756e6374696f6e206f6e4c6f67696e436f6d706c65746528777261707065722c757365726e616d652c70617373776f72642c72656d656d6265724d65297b54692e4170702e666972654576656e742827686964654163746976697479496e64696361746f7227293b76617220613d546974616e69756d2e55492e637265617465416c6572744469616c6f67287b7469746c653a274f6f70732e2e2e272c6d6573736167653a22546865206c6f67696e206f722070617373776f72642077657265206e6f7420636f72726563742e2020506c656173652074727920616761696e2e227d293b696628777261707065723d3d6e756c6c297b612e73686f7728293b72657475726e3b7d0a7365637572697479577261707065723d777261707065723b69662872656d656d6265724d65297b546974616e69756d2e4170702e50726f706572746965732e736574537472696e672822756e222c757365726e616d65293b546974616e69756d2e4170702e50726f706572746965732e736574537472696e6728227077222c70617373776f7264293b7d0a656c73657b546974616e69756d2e4170702e50726f706572746965732e736574537472696e672822756e222c6e756c6c293b546974616e69756d2e4170702e50726f706572746965732e736574537472696e6728227077222c6e756c6c293b7d0a73686f7744617368626f61726428293b7d0a66756e6374696f6e20657865637574654c6f67696e2865297b54692e4170702e666972654576656e742827646973706c61794163746976697479496e64696361746f72272c7b6d6573736167653a274c6f6767696e6720696e2e2e2e277d293b736572766963654c6f67696e28652e757365726e616d652c652e70617373776f72642c66756e6374696f6e2877726170706572297b6f6e4c6f67696e436f6d706c65746528777261707065722c652e757365726e616d652c652e70617373776f72642c652e72656d656d6265724d65293b7d2c6f6e4c6f67696e4661696c757265293b7d0a546974616e69756d2e4170702e6164644576656e744c697374656e657228226c6f67696e526571756573746564222c657865637574654c6f67696e293b") forKey:@"login_handlers_js"];
         [map setObject:dataWithHexString(@"54692e4170702e6164644576656e744c697374656e65722822646973706c61794163746976697479496e64696361746f72222c66756e6374696f6e2865297b7d293b54692e4170702e6164644576656e744c697374656e65722822686964654163746976697479496e64696361746f72222c66756e6374696f6e2865297b7d293b") forKey:@"progress_js"];
         [map setObject:dataWithHexString(@"66756e6374696f6e20706172736553657276696365526573706f6e736528726573706f6e736554657874297b696628726573706f6e7365546578743d3d6e756c6c7c7c726573706f6e7365546578743d3d2727297b72657475726e206e756c6c3b7d0a7472797b72657475726e204a534f4e2e706172736528726573706f6e736554657874293b7d0a636174636828657272297b72657475726e206e756c6c3b7d7d0a66756e6374696f6e20736572766963654c6f67696e28757365726e616d652c70617373776f72642c7375636365737343616c6c6261636b2c6661696c75726543616c6c6261636b297b68747470436c69656e742e6f6e6572726f723d6661696c75726543616c6c6261636b3b68747470436c69656e742e6f6e6c6f61643d66756e6374696f6e28297b7375636365737343616c6c6261636b28706172736553657276696365526573706f6e736528746869732e726573706f6e73655465787429293b7d3b68747470436c69656e742e6f70656e2827504f5354272c6d6f62696c65536572766963654261736555726c2b272f64617368626f6172646c6f67696e2f27293b68747470436c69656e742e73656e64287b757365726e616d653a757365726e616d652c70617373776f72643a70617373776f72647d293b7d0a66756e6374696f6e207365727669636547657444617368626f61726444617461287375636365737343616c6c6261636b2c6661696c75726543616c6c6261636b297b68747470436c69656e742e6f6e6572726f723d6661696c75726543616c6c6261636b3b68747470436c69656e742e6f6e6c6f61643d66756e6374696f6e28297b7375636365737343616c6c6261636b28706172736553657276696365526573706f6e736528746869732e726573706f6e73655465787429293b7d3b68747470436c69656e742e6f70656e2827474554272c6d6f62696c65536572766963654261736555726c2b272f64617368626f6172642f27293b68747470436c69656e742e73656e64286e756c6c293b7d0a66756e6374696f6e207365727669636541646452656365697074546f557365722866696c655265662c7375636365737343616c6c6261636b2c6661696c75726543616c6c6261636b297b7375636365737343616c6c6261636b2866696c65526566293b7d0a66756e6374696f6e207365727669636555706c6f6164526563656970742866696c654e616d652c696d6167652c7375636365737343616c6c6261636b2c6661696c75726543616c6c6261636b2c70726f677265737343616c6c6261636b297b68747470436c69656e742e6f6e6572726f723d6661696c75726543616c6c6261636b3b68747470436c69656e742e6f6e6c6f61643d66756e6374696f6e28297b7661722066696c655265663d706172736553657276696365526573706f6e736528746869732e726573706f6e736554657874293b69662866696c655265663d3d6e756c6c297b54692e4150492e646562756728274661696c656420746f20706172736520726573706f6e73653a20272b746869732e726573706f6e736554657874293b6661696c75726543616c6c6261636b286e756c6c293b72657475726e3b7d0a7365727669636541646452656365697074546f557365722866696c655265662c7375636365737343616c6c6261636b2c6661696c75726543616c6c6261636b293b7d3b68747470436c69656e742e6f6e73656e6473747265616d3d66756e6374696f6e2865297b70726f677265737343616c6c6261636b28652e70726f6772657373293b7d3b68747470436c69656e742e6f70656e2827504f5354272c73746f72616765536572766963654261736555726c2b272f66696c652f72656365697074732f27293b68747470436c69656e742e73656e64287b66696c654e616d654f766572726964653a66696c654e616d652c66696c653a696d6167657d293b7d") forKey:@"service_js"];
     }
     return [map objectForKey:path];
}

@end
