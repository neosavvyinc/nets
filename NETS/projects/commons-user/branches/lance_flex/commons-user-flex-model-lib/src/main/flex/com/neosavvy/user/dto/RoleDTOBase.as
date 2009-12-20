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

        private var __laziness:String = null;

        private var _id:int;
        private var _longName:String;
        private var _shortName:String;
        private var _users:ListCollectionView;

        meta function isInitialized(name:String = null):Boolean {
            if (!name)
                return __laziness === null;

            var property:* = this[name];
            return (
                (!(property is RoleDTO) || (property as RoleDTO).meta::isInitialized()) &&
                (!(property is IPersistentCollection) || (property as IPersistentCollection).isInitialized())
            );
        }

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

        public function set users(value:ListCollectionView):void {
            _users = value;
        }
        public function get users():ListCollectionView {
            return _users;
        }

//        public function readExternal(input:IDataInput):void {
//            __laziness = input.readObject() as String;
//            if (meta::isInitialized()) {
//                _id = input.readObject() as int;
//                _longName = input.readObject() as String;
//                _shortName = input.readObject() as String;
//                _users = input.readObject() as ListCollectionView;
//            }
//            else {
//                _id = input.readObject() as int;
//            }
//        }
//
//        public function writeExternal(output:IDataOutput):void {
//            output.writeObject(__laziness);
//            if (meta::isInitialized()) {
//                output.writeObject(_id);
//                output.writeObject(_longName);
//                output.writeObject(_shortName);
//                output.writeObject(_users);
//            }
//            else {
//                output.writeObject(_id);
//            }
//        }
    }
}