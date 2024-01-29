import { styled } from '@tamagui/core'
import { requireNativeViewManager } from 'expo-modules-core'
import * as React from 'react'
import { Platform } from 'react-native'

const NativeView: React.ComponentType<any> | null =
  Platform.OS === 'ios' ? requireNativeViewManager('Progress') : null

function ProgressWrapper(props: any) {
  const max = props.max ?? 1
  if (!NativeView) return null
  return <NativeView {...props} max={max} />
}

export const Progress = styled(ProgressWrapper, {
  name: 'Progress',
})

// @ts-ignore
Progress.Indicator = (props: any) => null
