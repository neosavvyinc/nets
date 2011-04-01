<%--
  GRANITE DATA SERVICES
  Copyright (C) 2007-2008 ADEQUATE SYSTEMS SARL

  This file is part of Granite Data Services.

  Granite Data Services is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation; either version 3 of the License, or (at your
  option) any later version.

  Granite Data Services is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this library; if not, see <http://www.gnu.org/licenses/>.

  @author Franck WOLFF
--%>/**
 * Generated by Gas3 v${gVersion} (Granite Data Services).
 *
 * WARNING: DO NOT CHANGE THIS FILE. IT MAY BE OVERRIDDEN EACH TIME YOU USE
 * THE GENERATOR.
 */

package ${jClass.as3Type.packageName} {

    [Bindable]
   	[RemoteClass(alias="${jClass.qualifiedName}")]
    public class ${jClass.as3Type.name} {
<%

        for (jEnumValue in jClass.enumValues) {%>
        public static const ${jEnumValue.name}:${jClass.name} = new ${jClass.name}("${jEnumValue.name}");<%
        }%>

        private var _value:String;

        function ${jClass.as3Type.name}(value:String = "unset") {
	    _value = value;
        }
       
        public function set value(value:String):void {
        	_value = value;
        }
        
        public function get value():String {
            return _value;
        }

        public function toString():String {
            return value;
        }
 
        public function equals(other:${jClass.as3Type.name}):Boolean {
            return value == other.value;
        }

        protected function getConstants():Array {
            return constants;
        }

        public static function get constants():Array {
            return [<%
		        for (jEnumValue in jClass.enumValues) {
		        	if (jEnumValue != jClass.firstEnumValue) {
		        		%>, <%
		        	}
		        	%>${jEnumValue.name}<%
		        }
	        %>];
        }
    }
}
