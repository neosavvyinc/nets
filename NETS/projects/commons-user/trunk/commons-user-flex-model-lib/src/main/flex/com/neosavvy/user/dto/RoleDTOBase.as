/**
 * Generated by Gas3 v1.1.0 (Granite Data Services).
 *
 * WARNING: DO NOT CHANGE THIS FILE. IT MAY BE OVERRIDDEN EACH TIME YOU USE
 * THE GENERATOR. CHANGE INSTEAD THE INHERITED CLASS (RoleDTO.as).
 */

package com.neosavvy.user.dto {

    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.IExternalizable;
    import mx.collections.ListCollectionView;
    import org.granite.collections.IPersistentCollection;
    import org.granite.meta;

    use namespace meta;

    [Bindable]
    public class RoleDTOBase {

        private var _id:int;
        private var _longName:String;
        private var _shortName:String;
        private var _userCompanyRoles:ListCollectionView;


        public function set id(value:int):void {
            _id = value;
        }
        public function get id():int {
            return _id;
        }

        public function set longName(value:String):void {
            _longName = value;
        }
        public function get longName():String {
            return _longName;
        }

        public function set shortName(value:String):void {
            _shortName = value;
        }
        public function get shortName():String {
            return _shortName;
        }

        public function set userCompanyRoles(value:ListCollectionView):void {
            _userCompanyRoles = value;
        }
        public function get userCompanyRoles():ListCollectionView {
            return _userCompanyRoles;
        }

    }
}