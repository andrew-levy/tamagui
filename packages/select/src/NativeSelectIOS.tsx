import { styled } from '@tamagui/core'
import { requireNativeViewManager } from 'expo-modules-core'
import * as React from 'react'
import { Platform } from 'react-native'

import { SelectItemText } from './SelectItemText'

const NativeView: React.ComponentType<any> | null =
  Platform.OS === 'ios' ? requireNativeViewManager('Select') : null

function NativeSelectWrapper(props: any) {
  if (!NativeView) return null
  return (
    <NativeView
      {...props}
      type={props.nativeType}
      options={convertReactChildrenToStrings(props.children)}
      onValueChange={(e) => {
        props.onValueChange?.(e.nativeEvent.value)
      }}
      children={null}
    />
  )
}

export const NativeSelectIOS = styled(NativeSelectWrapper, {
  name: 'Select',
  width: 200,
  height: 20,
})

/**
 * Since the Select API uses children to pass its options, we need to convert
 * the React children into a string array for the native component. Only
 * strings and numbers are supported as of now.
 */
function convertReactChildrenToStrings(
  children: React.ReactNode,
  parent: React.ReactNode = null
) {
  return React.Children.map(children, (child) => {
    if (
      // @ts-ignore
      parent?.type === SelectItemText &&
      (typeof child === 'string' || typeof child === 'number')
    ) {
      return child
    }
    if (React.isValidElement(child)) {
      return convertReactChildrenToStrings(child.props.children, child)
    }
    return null
  })
}
